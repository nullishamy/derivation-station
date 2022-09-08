# NixOS Config

This is my NixOS config, including my home-manager config.

The files in `os/` are symlinked to `/etc/nixos/` as this config is intended to be stored in the user's home dir.

These files must be symlinked:
```sh
#!/usr/bin/env bash

sudo ln -s $(pwd)/os/configuration.nix /etc/nixos/configuration.nix
sudo ln -s $(pwd)/os/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
```

When installing home manager, the following must be run as root / with sudo:

```sh
#!/usr/bin/env bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
sudo nix-channel --update
```

When running home manager, you must pass the config path:

```sh
#!/usr/bin/env bash
home-manager switch -f $HOME/nixos/profiles/personal.nix
```

Credit: https://www.reddit.com/r/wallpapers/comments/wocpkm/onedark_cubes_wallpaper/
