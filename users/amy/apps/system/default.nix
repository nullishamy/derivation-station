{config, ...}: {
  imports = [
    ./xdg.nix
    ./sops.nix
  ];

  config.xdg.configFile."nixpkgs/config.nix" = {source = ./nixpkgs.nix;};
}
