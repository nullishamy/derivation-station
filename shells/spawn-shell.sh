#!/usr/bin/env bash

if [[ $# -gt 1 ]]; then
    nix-shell ~/shells/"$1".nix --arg extras "with import<nixpkgs> { }; ${@:2}";
else
    nix-shell ~/shells/"$1".nix
fi
