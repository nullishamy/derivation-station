{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager?ref=release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    flake-utils.url = "github:numtide/flake-utils";

    sops.url = "github:Mic92/sops-nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    pre-commit-hooks,
    flake-utils,
    sops,
    ...
  }: let
    system = import ./users/amy/config.nix;

    overlays = [
      import
      ./users/${system.currentUser}/overlays
    ];
  in
    {
      nixosConfigurations.nixon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({
            config,
            pkgs,
            ...
          }: {
            nixpkgs.overlays = overlays;
          })
          ./machines/desktop

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [
                sops.homeManagerModules.sops
              ];
              extraSpecialArgs = {
                flakePath = "/home/${system.currentUser}/nixos";
                inherit system;
              };
            };
          }
        ];
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: {
      checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            alejandra.enable = true;
            editorconfig-checker.enable = true;
            deadnix.enable = true;
            shellcheck.enable = true;
            stylua.enable = true;
          };
          settings.deadnix = {
            noLambdaPatternNames = true;
            noLambdaArg = true;
          };
        };
      };
      devShell = let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          packages = [
            pkgs.just
            pkgs.sops
          ];
        };
    });
}
