{ pkgs, lib, makeWrapper, runCommandNoCC, neovim, sumneko-lua-language-server, ...}:

runCommandNoCC "nvim" { nativeBuildInputs = [makeWrapper]; } ''
  mkdir -p $out/bin
  makeWrapper ${neovim}/bin/nvim $out/bin/nvim \
    --prefix PATH : ${lib.makeBinPath [ sumneko-lua-language-server ]}
''
