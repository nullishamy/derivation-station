#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p inetutils python3 python39Packages.xdg python39Packages.coloredlogs

import sys
import tempfile
import argparse
import pathlib
import os
import xdg
import shutil
import coloredlogs
import logging
import tarfile
import datetime
import ftplib

PROG_NAME = 'nix-backup'
logger = logging.getLogger(PROG_NAME)

# Default to warn, we will set this if we parse args successfully
coloredlogs.install(level='WARN', logger=logger)

def xdg_dirs():
    dirs = {
        'config': [xdg.xdg_config_home()],
    }

    xdg_extra_dirs = {
        'XDG_DESKTOP_DIR': 'desktop',
        'XDG_PICTURES_DIR': 'pictures',
        'XDG_VIDEOS_DIR': 'videos',
        'XDG_MUSIC_DIR': 'music',
        'XDG_DOCUMENTS_DIR': 'documents'
    }

    try:
        logger.info(f'Beginning parse of user-dirs.dirs')
        with open(os.path.join(xdg.xdg_config_home(), "user-dirs.dirs")) as config_file:
            lines = config_file.readlines()

            for line in lines:
                key, value = line.split('=')
                logger.debug(f'Parsed user-dir line {key} => {value}')

                if key in xdg_extra_dirs:
                    # Strip out the '"' and newlines that are present in the values
                    dirs[xdg_extra_dirs[key]] = [pathlib.Path(value.replace('"', '').strip('\n'))]
                else:
                    logger.debug(f'Ignoring key {key}')
                    pass
    except:
        logger.info('Failed to open user-dirs.dirs, assuming non unix and returning the defaults only')
        return dirs

    return dirs

def parse_args():
    parser = argparse.ArgumentParser(
        prog = PROG_NAME,
        description = 'Backs up relevant files',
    )

    parser.add_argument('--host', help='The host to use for the FTP connection', required=True)
    parser.add_argument('--port', help='The port to use for the FTP connection', required=False, default=21, type=int)
    parser.add_argument('--tarball', help='The existing tarball to use', required=False, type=pathlib.Path)
    parser.add_argument('--exclude-defaults', action='store_true', help='Exclude the default directories from being backed up.', required=False)
    parser.add_argument('-o', '--output-dir',  help='The output directory to put the tarballs in.', required=False, default='./archives', type=pathlib.Path)
    parser.add_argument('-d', '--destination-dir',  help='The destination directory', required=False, default='Backup')
    parser.add_argument('-v', action='store_true', help='Enable verbose logging', required=False)
    parser.add_argument('-vv', action='store_true', help='Enable trace logging', required=False)
    parser.add_argument('-u', '--username', help='The username to use for the FTP connection', required=False, default='anonymous')
    parser.add_argument('-p', '--password', help='The password to use for the FTP connection', required=False, default='anonymous')
    parser.add_argument('-f', '--files', help='The additional files / directories to backup', nargs='*', type=pathlib.Path)

    return parser.parse_args()

def create_tarball(paths: dict[str, list[pathlib.Path]], output_dir: pathlib.Path) -> pathlib.Path:
    # Create working directory to assemble tarball structure
    work_dir = tempfile.TemporaryDirectory()

    out_paths = []

    # Copy all files into the working directory
    for dest_dir_name, source_values in paths.items():
        logger.debug(f'Raw dest: {dest_dir_name} Sources: {source_values}')
        dest_dir = pathlib.Path(work_dir.name, dest_dir_name).resolve()

        for source in source_values:
            logger.info(f'Copying {source.as_posix()} to {dest_dir.as_posix()}')

            if not source.exists():
                logger.error(f'Source {source.as_posix()} does not exist, skipping.')
                continue

            if source.is_dir(): 
                # Enumerate and copy all files
                path = shutil.copytree(source.resolve(), dest_dir, symlinks=True)
                out_paths.append(path)
            else:
                # Only copy this one, it's a single file
                path = shutil.copy2(source.resolve(), dest_dir)
                out_paths.append(path)

    # Assemble tarball
    logger.info('Assembling tarball')
    timestamp = datetime.datetime.now().strftime('%b%d-%X')
    tar_path = pathlib.Path(output_dir, f'backup-{timestamp}.tar.gz')
    with tarfile.open(tar_path, 'x:gz') as tarball:
        for path in out_paths:
            logger.debug(f'Adding path {path}')
            tarball.add(path.resolve())

    return tar_path

def upload_to_ftp(host: str, port: int, username: str, password: str, tarball: pathlib.Path, destination: str):
    logger.info(f'Logging in with username {username} on {host}:{port}')
    server = ftplib.FTP()
    server.connect(host, port)
    server.login(username, password)

    logger.info('Connected!')
    logger.debug(f'Changing to {destination}')

    server.cwd(destination)

    logger.debug(f'Uploading {tarball.as_posix()}')
    with open(tarball, 'rb') as tar_file:
        server.storbinary(f'STOR {tarball.name}', tar_file)
    logger.debug('Disconnecting')

    server.quit()

def main():
    args = parse_args()

    # Verbosity level 1
    if args.v:
        coloredlogs.install(level='INFO', logger=logger)
        logger.info('Installed verbose logging')

    # Verbosity level 2
    if args.vv:
        coloredlogs.install(level='DEBUG', logger=logger)
        logger.debug('Installed trace logging')

    logger.info('Checkpoint 1: Args')

    logger.debug('Setting up file set')

    files = {
        'additional': args.files or []
    }

    if not args.exclude_defaults:
        logger.debug('Including default values')
        # Push xdg dirs into the files
        files.update(xdg_dirs())

    if args.exclude_defaults and len(files['additional']) == 0:
        logger.critical('No files specified for backup (defaults excluded)')
        sys.exit(1)

    logger.debug('Attempting to create output dir')
    if not os.path.exists(args.output_dir):
        os.makedirs(args.output_dir)
        logger.debug('Created output dir')
    
    if args.tarball:
        tarball = args.tarball.resolve() 
    else:
        tarball = create_tarball(files, args.output_dir)

    logger.debug(f'Tarball path: {tarball.as_posix()}')
    logger.info('Checkpoint 2: Tarball')

    logger.debug('Starting upload process')
    upload_to_ftp(args.host, args.port, args.username, args.password, tarball, args.destination_dir)

    logger.info('Checkpoint 3: FTP')
    logger.info('Backup complete, exiting!')
    sys.exit(0)

if __name__ == '__main__':
    try:
        main()
    except Exception as err:
        print('An error occured whilst running the script:', file=sys.stderr)
        raise err



