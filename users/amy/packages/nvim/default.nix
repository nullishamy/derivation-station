{
  pkgs,
  lib,
  makeWrapper,
  runCommandNoCC,
  neovim-unwrapped,
  sumneko-lua-language-server,
  stylua,
  selene,
  clang,
  clang-tools,
  go,
  xclip,
  nodejs,
  python3,
  sqlite,
  cargo,
  rustc,
  luarocks,
  gcc,
  rust-analyzer,
  statix,
  gitlint,
  alejandra,
  rnix-lsp,
  nodePackages,
  ...
}:
runCommandNoCC "nvim" {nativeBuildInputs = [makeWrapper];} ''
  mkdir -p $out/bin
  makeWrapper ${neovim-unwrapped}/bin/nvim $out/bin/nvim \
    --set CC "gcc" \
    --set NVIM_CONFIG_ROOT "/home/amy/nixos/users/amy/apps/dedicated/nvim-config" \
    --set SQLITE_LIB_PATH "${sqlite.out}/lib/libsqlite3.so" \
    --prefix PATH : ${
    lib.makeBinPath [
      sumneko-lua-language-server
      stylua
      selene
      clang
      clang-tools
      gcc
      gitlint
      luarocks
      cargo
      rustc
      rust-analyzer
      nodejs
      python3
      go
      xclip
      statix
      alejandra
      rnix-lsp

      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      nodePackages.vscode-json-languageserver-bin
      nodePackages.prettier
      nodePackages.pyright
    ]
  }
''
