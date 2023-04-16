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
  sumneko.lua
  esbenp.prettier-vscode
  WakaTime.vscode-wakatime

  (vscPackage {
    ref = {
      name = "gitlens";
      publisher = "eamodio";
      version = "13.5.0";
      sha256 = "sha256-zBaWpa18ix5xd4r6Ut3pfPum/nMJduHoyCiIgjwhsa0=";
    };
    meta = with lib; {
      changelog = "https://marketplace.visualstudio.com/items/eamodio.gitlens/changelog";
      description = "GitLens supercharges the Git capabilities built into Visual Studio Code.";
      longDescription = ''
        Supercharge the Git capabilities built into Visual Studio Code — Visualize code authorship at a glance via Git
        blame annotations and code lens, seamlessly navigate and explore Git repositories, gain valuable insights via
        powerful comparison commands, and so much more
      '';
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens";
      homepage = "https://gitlens.amod.io/";
      license = licenses.mit;
      maintainers = with maintainers; [ratsclub];
    };
  })

  (vscPackage {
    ref = {
      name = "vscord";
      publisher = "LeonardSSH";
      version = "5.1.7";
      sha256 = "sha256-YIuCUdAF0J/HbsQJBv3jUQBylWCnl4xDUBn5RVtb7AE=";
    };
    meta = {
      license = lib.licenses.mit;
    };
  })

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
