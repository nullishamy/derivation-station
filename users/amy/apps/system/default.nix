{ config, ... }: {
  imports = [
    ./xdg.nix
  ];

  config.home.file.".config/nixpkgs/config.nix" = { source = ./nixpkgs.nix; };
}
