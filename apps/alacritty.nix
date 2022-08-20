# Alacritty settings

{ config, lib, pkgs, ...}:

{
  programs.alacritty = {
    enable = true; 
    settings = {
      # Colors (Gruvbox dark)
      colors = {
        primary = {
          background = "0x282828";
          foreground = "0xebdbb2";
        };        
        normal = {
          black =   "0x282828"; 
          red =     "0xcc241d";
          green =   "0x98971a";
          yellow =  "0xd79921";
          blue =    "0x458588";
          magenta = "0xb16286";
          cyan =    "0x689d6a";
          white =   "0xa89984";
        };
        bright = {
          black =   "0x928374"; 
          red =     "0xfb4934";
          green =   "0xb8bb26";
          yellow =  "0xfabd2f";
          blue =    "0x83a598";
          magenta = "0xd3869b";
          cyan =    "0x8ec07c";
          white =   "0xebdbb2";
        };
      }; 

      font = {
        normal = {
          family = "Hack Nerd Font Mono";
          style = "Regular";
        };

        bold = {
          family = "Hack Nerd Font Mono";
          style = "Bold";
        };

        italic = {
          family = "Hack Nerd Font Mono";
          style = "Italic";
        };

        bold_italic = {
          family = "Hack Nerd Font Mono";
          style = "Bold Italic";
        };

        size = 13.0;
      };

      cursor = {
        style = {
          shape = "Beam";
          blinking = "Off";
        };
      };
    };
  };
}
