# Git settings

{ config, lib, pkgs, ...}:

let
  shouldUseSSH = true;
  ifSSH = c: if shouldUseSSH then c else { };
in {
  programs.git = {
    enable = true;

    userEmail = "git@amyerskine.me";
    userName = "nullishamy";

    extraConfig = {
      gpg = {
        format = "ssh";
      };

      url = ifSSH {
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

      user = {
        signingKey = "/home/amy/.ssh/github.pub";
      };
    };
  };
}
