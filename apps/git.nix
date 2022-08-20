# Git settings

{ config, lib, pkgs, ...}:

{
  programs.git = {
    enable = true;

    userEmail = "amy.codes@null.net";
    userName = "nullishamy";
    
    signing = {
      key = "5BAB63DCC2BF4F58";
      signByDefault = true;
    };
  };
}
