# NixOS Config

This is my NixOS config, including my home-manager config.

To set the symlinks up for the config, run `./install.sh` as root.
To remove the symlinks, run `./clean.sh` as root.

When running home manager, you must pass the config path:

```sh
#!/usr/bin/env bash
home-manager switch -f $HOME/nixos/profiles/personal.nix
```

Wallpaper credit: https://github.com/catppuccin/wallpapers/blob/main/minimalistic/darker_unicat.png
