# Cargo settings

{ config, lib, pkgs, ...}:

{
  programs.cargo = {
    enable = true;
    settings = {
      net = {
        git-fetch-with-cli = true;
      };
    };
  };
}


