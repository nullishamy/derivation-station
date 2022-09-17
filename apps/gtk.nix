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
      inherit theme;
      icons = iconTheme;
    }
  ];
in {
  config.gtk = {
    enable = true;
    inherit theme;
    inherit iconTheme;
  };
}
