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
}
