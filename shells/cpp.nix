{ pkgs ? import <nixpkgs> {}, extras }:

pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ 
        clang-tools
        gcc
        cmake
        remake
        python3
        ninja
        extras
    ];
}
