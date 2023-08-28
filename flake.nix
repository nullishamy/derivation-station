{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager?ref=release-22.11";

    flake-utils.url = "github:numtide/flake-utils";

    nix-index-database.url = "github:Mic92/nix-index-database";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    sops.url = "github:Mic92/sops-nix";

    nu_scripts = {
      type = "git";
      url = "https://github.com/nushell/nu_scripts";
      submodules = true;
      flake = false;
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    pre-commit-hooks,
    flake-utils,
    nix-index-database,
    nu_scripts,
    nix-vscode-extensions,
    sops,
    ...
  }: let
    system = import ./users/amy/config.nix;
    overlays = final: prev:
      {
        unstable = import nixpkgs-unstable {
          inherit (prev) system;
          config.allowUnfree = true;
        };
      }
      // (import ./users/${system.currentUser}/overlays final prev);
  in
    {
      nixosConfigurations.nixon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/desktop

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [
                nix-index-database.hmModules.nix-index
                sops.homeManagerModules.sops
              ];
              extraSpecialArgs = {
                flakePath = "/home/${system.currentUser}/nixos";
                inherit nu_scripts;
                inherit system;
                inherit nix-vscode-extensions;
              };
            };
          }

          ({config, ...}: {
            config = {
              nixpkgs.overlays = [overlays];
            };
          })
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
        unstable = nixpkgs-unstable.legacyPackages.${system};
      in
        pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          packages = [
            unstable.just
            pkgs.sops
            pkgs.nixpkgs-fmt
          ];
        };
    });
}
