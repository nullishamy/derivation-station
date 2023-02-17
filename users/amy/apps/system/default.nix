{config, ...}: {
  imports = [
    ./xdg.nix
  ];

  config.xdg.configFile."nixpkgs/config.nix" = {source = ./nixpkgs.nix;};
}
