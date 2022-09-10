{ pkgs, lib, makeWrapper, runCommandNoCC, neovim, sumneko-lua-language-server, stylua, selene, clang, clang-tools, go, xclip, nodejs, cargo, rustc, luarocks, gcc, rust-analyzer, ...}:

runCommandNoCC "nvim" { nativeBuildInputs = [makeWrapper]; } ''
  mkdir -p $out/bin
  makeWrapper ${neovim}/bin/nvim $out/bin/nvim \
    --prefix PATH : ${lib.makeBinPath [ 
      sumneko-lua-language-server 
      stylua 
      selene 
      clang
      clang-tools
      gcc
      luarocks
      cargo
      rustc
      rust-analyzer
      nodejs
      go
      xclip
    ]}
''
