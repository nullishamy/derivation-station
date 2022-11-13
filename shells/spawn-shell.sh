#!/usr/bin/env bash

if [[ "$#" -gt 1 ]]; then
    # Run the shell given the rest of the input as extra packages
    extras="${@:2}"
    nix-shell -E "with import <nixpkgs> { }; runCommand \"shell\" { buildInputs = [ $extras ]; } \"\""
else
    nix-shell ~/shells/"$1".nix
fi
