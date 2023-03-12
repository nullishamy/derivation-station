# Cargo settings
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.cargo = {
    enable = true;
    file = "${config.xdg.dataHome}/cargo/config.toml";
    settings = {
      net = {
        git-fetch-with-cli = true;
      };
    };
  };
}
