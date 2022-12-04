#!/usr/bin/env bash
set -euxo pipefail
 
 # Make sure we are root
id=$(id -g)

if [ $id -ne 0 ] 
then
    echo "[error]: Not running as root.";
    exit 1;
fi

echo "[info]: Linking local files with /etc."
# Link the os files with /etc
ln -s $(pwd)/os/configuration.nix /etc/nixos/configuration.nix
ln -s $(pwd)/os/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

echo "[info]: Adding home-manager channels."
# Install home-manager channels
nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
nix-channel --update
