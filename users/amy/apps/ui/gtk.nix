# GTK settings
{
  config,
  lib,
  pkgs,
  ...
}: let
  theme = {
    name = "Catppuccin-Mocha-Lavender";
    package = pkgs.catppuccin-gtk;
  };

  iconTheme = {
    name = "oomox-gruvbox-dark";
    package = pkgs.gruvbox-dark-icons-gtk;
  };

  imports = [
    ./gtk2.nix
    {
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
