#!/usr/bin/env bash
set -euxo pipefail

# Make sure we are root
id=$(id -g)

if [ $id -ne 0 ] 
then
    echo "[error]: Not running as root.";
    exit 1;
fi
 
echo "[info]: Removing linked files in /etc. You will need to restore some sort of config manually."
rm /etc/nixos/configuration.nix
rm /etc/nixos/hardware-configuration.nix
