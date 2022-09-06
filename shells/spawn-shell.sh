#!/usr/bin/env bash
nix-shell ~/shells/"$1".nix --arg extras "with import<nixpkgs> { }; ${@:2}";
