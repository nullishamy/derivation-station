{
  config,
  lib,
  pkgs,
  flakePath,
  system,
  ...
}: {
  imports = [
    ./zsh.nix
    ./nu
  ];

  programs.atuin = {
    enable = true;
    package = pkgs.unstable.atuin;
  };
}
