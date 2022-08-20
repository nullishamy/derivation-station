# GTK settings

{ config, lib, pkgs, ...}:

let 
  theme = {
    name = "gruvbox-dark";
    package = pkgs.gruvbox-dark-gtk;
  };

  iconTheme = {
    name = "oomox-gruvbox-dark";
    package = pkgs.gruvbox-dark-icons-gtk;
  };

  imports = [ 
    ./gtk2.nix {
      theme = theme;
      icons = iconTheme;
    }
  ];
in {
  config.gtk = {
    enable = true;
    theme = theme;
    iconTheme = iconTheme;
  };
}
