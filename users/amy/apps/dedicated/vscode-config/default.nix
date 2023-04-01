{
  config,
  flakePath,
  lib,
  pkgs,
  ...
}: let
  vscPackage = data:
    pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = data.ref;
      meta = data.meta;
    };
in {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.unstable.vscode-extensions; [
      jnoortheen.nix-ide
      matklad.rust-analyzer
      mkhl.direnv
      catppuccin.catppuccin-vsc
      pkief.material-icon-theme
      redhat.vscode-yaml
      tamasfe.even-better-toml
      vscodevim.vim
      (vscPackage {
        ref = {
          name = "vscode-todo-highlight";
          publisher = "wayou";
          version = "1.0.5";
          sha256 = "sha256-CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
        };
        meta = {
          license = lib.licenses.mit;
        };
      })
    ];
    mutableExtensionsDir = true;
  };
  home.file = {
    "${config.xdg.configHome}/Code/User/settings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/dedicated/vscode-config/settings.json";
    };
    "${config.xdg.configHome}/Code/User/keybindings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/dedicated/vscode-config/keybindings.json";
    };
  };
}
