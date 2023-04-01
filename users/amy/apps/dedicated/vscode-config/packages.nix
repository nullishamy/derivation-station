{
  pkgs,
  lib,
  ...
}:
with pkgs.unstable.vscode-extensions; let
  vscPackage = data:
    pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = data.ref;
      meta = data.meta;
    };
in [
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
]
