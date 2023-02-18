{
  config,
  sops,
  ...
}: {
  imports = [
    sops
    ./xdg.nix
    ./sops.nix
  ];

  config.xdg.configFile."nixpkgs/config.nix" = {source = ./nixpkgs.nix;};
}
