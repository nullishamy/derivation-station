{ pkgs
, lib
, makeWrapper
, runCommandNoCC
, neovim
, sumneko-lua-language-server
, stylua
, selene
, clang
, clang-tools
, go
, xclip
, nodejs
, python3
, cargo
, rustc
, luarocks
, gcc
, rust-analyzer
, statix
, nixpkgs-fmt
, ...
}:

runCommandNoCC "nvim" { nativeBuildInputs = [ makeWrapper ]; } ''
  mkdir -p $out/bin
  makeWrapper ${neovim}/bin/nvim $out/bin/nvim \
    --set CC "gcc" \
    --set NVIM_CONFIG_ROOT "/home/amy/nixos/users/amy/apps/dedicated/nvim-config" \
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
      python3
      go
      xclip
      statix
      nixpkgs-fmt
    ]}
''
