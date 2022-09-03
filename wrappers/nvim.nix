{ pkgs, lib, makeWrapper, runCommandNoCC, neovim, sumneko-lua-language-server, stylua, selene, ...}:

runCommandNoCC "nvim" { nativeBuildInputs = [makeWrapper]; } ''
  mkdir -p $out/bin
  makeWrapper ${neovim}/bin/nvim $out/bin/nvim \
    --prefix PATH : ${lib.makeBinPath [ 
      sumneko-lua-language-server 
      stylua 
      selene 
      clang
      gcc
      luarocks
      cargo
      nodejs
      go
      xclip
    ]}
''
