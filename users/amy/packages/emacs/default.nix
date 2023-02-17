{
  pkgs,
  lib,
  makeWrapper,
  emacs,
  runCommandNoCC,
  clang,
  nodejs,
  python3,
  cargo,
  rustc,
  gcc,
  lua,
  sumneko-lua-language-server,
  nodePackages,
  python39Packages,
  rust-analyzer,
  binutils,
  ripgrep,
  libvterm,
  gnutls,
  fd,
  imagemagick,
  zstd,
  sqlite,
  editorconfig-core-c,
  emacs-all-the-icons-fonts,
  nixfmt,
  ...
}:
runCommandNoCC "emacs" {nativeBuildInputs = [makeWrapper];} ''
  mkdir -p $out/bin
  cp ${emacs}/bin/emacsclient $out/bin
  makeWrapper ${emacs}/bin/emacs $out/bin/emacs \
    --set DOOMDIR "~/.config/doom-config" \
    --set DOOMLOCALDIR "~/.config/doom-local" \
    --set DOOMPROFILELOADFILE "~/.config/doom-local/profiles.el" \
    --set EMACS "${emacs}/bin/emacs" \
    --prefix _PATH : ${lib.makeBinPath [
    # Dependencies
    binutils
    (ripgrep.override {withPCRE2 = true;})
    libvterm
    gnutls
    fd
    imagemagick
    zstd
    sqlite
    editorconfig-core-c
    emacs-all-the-icons-fonts

    # General tools
    clang
    lua
    gcc
    cargo
    rustc
    nodejs
    python3
    python39Packages.pip

    # LSP
    sumneko-lua-language-server
    nodePackages.typescript-language-server
    nodePackages.pyright
    rust-analyzer

    # Formatting
    nodePackages.prettier
    nixfmt

    # DAP
  ]}
''
