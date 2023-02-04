# Git settings

{ config, lib, pkgs, ...}:

{
  programs.git = {
    enable = true;

    userEmail = "git@amyerskine.me";
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

      commit = {
        gpgsign = true;
      };

      tag = {
        gpgsign = true;
      };
    };
  };
}
