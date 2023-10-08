{
  pkgs,
  lib,
  nix-vscode-extensions,
  ...
}: let
  marketplace = nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
in
  with marketplace; [
    formulahendry.auto-rename-tag
    aaron-bond.better-comments
    # catppuccin.catppuccin-vsc -- not managed by nix because the configurability is broken on Nix. installed by hand
    catppuccin.catppuccin-vsc-icons
    dotenv.dotenv-vscode
    pkgs.vscode-extensions.vadimcn.vscode-lldb
    kamikillerto.vscode-colorize
    mkhl.direnv
    leonardssh.vscord
    dbaeumer.vscode-eslint
    tamasfe.even-better-toml
    eamodio.gitlens
    firsttris.vscode-jest-runner
    fwcd.kotlin
    sumneko.lua
    pkief.material-icon-theme
    jnoortheen.nix-ide
    ionutvmi.path-autocomplete
    esbenp.prettier-vscode
    prisma.prisma
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode.remote-explorer
    rust-lang.rust-analyzer
    bradlc.vscode-tailwindcss
    pdesaulniers.vscode-teal
    vscodevim.vim
    thenuprojectcontributors.vscode-nushell-lang
    wakatime.vscode-wakatime
    redhat.vscode-yaml
    streetsidesoftware.code-spell-checker
  ]
