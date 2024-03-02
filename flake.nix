{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager?ref=release-23.11";

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
    flake-utils,
    ...
  } @ inputs: let
    system = import ./users/amy/config.nix;
    inherit inputs;
    overlays = final: prev:
      {
        unstable = import inputs.nixpkgs-unstable {
          inherit (prev) system;
          config.allowUnfree = true;
        };
      }
      // (import ./users/${system.currentUser}/overlays final prev);
  in
    {
      nixosConfigurations.nixon = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({
            config,
            pkgs,
            lib,
            ...
          }: (import ./machines/desktop {
            inherit config inputs pkgs lib;
          }))

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [
                inputs.nix-index-database.hmModules.nix-index
                inputs.sops.homeManagerModules.sops
              ];
              extraSpecialArgs = {
                flakePath = "/home/${system.currentUser}/nixos";
                inherit (inputs) nu_scripts nix-vscode-extensions;
                inherit system;
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
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
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
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      in
        pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          packages = [
            unstable.just
            pkgs.sops
            pkgs.nixpkgs-fmt
            pkgs.nix-output-monitor
            pkgs.nvd
          ];
        };
    });
}
