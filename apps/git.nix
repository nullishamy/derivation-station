# Git settings

{ config, lib, pkgs, ...}:

{
  programs.git = {
    enable = true;

    userEmail = "amy.codes@null.net";
    userName = "nullishamy";

    signing = {
      key = "/home/amy/.ssh/github.pub";
      signByDefault = true;
    };

    extraConfig = {
      gpg = {
        format = "ssh";
      };

      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };

      init = {
        defaultBranch = "master";
      };
    };
  };
}
