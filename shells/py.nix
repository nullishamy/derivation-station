{ pkgs ? import <nixpkgs> {}, extras ? "" }:

pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ 
        python
        extras
    ];
}
