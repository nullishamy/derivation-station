# Rofi settings

{ config, lib, pkgs, ...}:

{
  programs.rofi = {
    enable = true;
    # Builtin with rofi since v1.3.0
    theme = "gruvbox-dark-hard";
    font = "Hack Nerd Font Mono 13";
  };
}
