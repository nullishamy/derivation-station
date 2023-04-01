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
  formulahendry.auto-rename-tag
  kamikillerto.vscode-colorize
  streetsidesoftware.code-spell-checker
  (vscPackage {
    ref = {
      name = "better-comments";
      publisher = "aaron-bond";
      version = "3.0.2";
      sha256 = "sha256-hQmA8PWjf2Nd60v5EAuqqD8LIEu7slrNs8luc3ePgZc=";
    };
    meta = {
      license = lib.licenses.mit;
    };
  })
]
