{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ 
        clang-tools
        gcc
        cmake
        remake
        python3
        ninja
    ];
}
