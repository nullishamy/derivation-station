system_name := "nixon"

# HACK: Use b64 because bash is dumb and stupid
# HACK: Redirect stderr to /dev/null because nixos is dumb and stupid
hardware_config :=  `sudo nixos-generate-config --show-hardware-config 2>/dev/null | base64 -w0`
dir := justfile_directory()

[private]
_default:
  @just --list

[private]
_build-system type:
    sudo nixos-rebuild {{type}} --flake "{{dir}}#{{system_name}}"

# Setup the OS for the first time
setup:
    #!/usr/bin/env bash

    if [[ -d "{{dir}}/machines/desktop_customised" ]]; then
        echo "ERROR: Setup has already completed (custom desktop dir exists)" && exit 1
    fi

    read -p "New username? " username
    read -p "New password? " password

    echo "Copying desktop files.."
    mkdir -p "{{dir}}/machines/desktop_customised"
    cp -r "{{dir}}/machines/desktop/"* "{{dir}}/machines/desktop_customised"
    echo "Done!"


    echo "Copying user files.."
    mkdir -p "{{dir}}/users/$username/"
    cp -r "{{dir}}/users/amy/"* "{{dir}}/users/$username"
    echo "Done!"


    echo "Setting values into config"
    sed -i "s/currentUser = \"\w*\"/currentUser = \"${username}\"/g" "{{dir}}/users/$username/config.nix"

    hashedPassword=$(echo "$password" | mkpasswd -m sha-512 --stdin)
    sed -i "s&hashedPassword = \".*\"&hashedPassword = \"${hashedPassword}\"&g" "{{dir}}/users/$username/default.nix"

    sed -i "s&system = import .*;&system = import ../../users/${username}/config.nix;&g" "{{dir}}/machines/desktop_customised/default.nix"
    sed -i "s&system = import .*;&system = import ../../users/${username}/config.nix;&g" "{{dir}}/flake.nix"
    sed -i "s&./machines/desktop&./machines/desktop_customised&g" "{{dir}}/flake.nix"
    echo "Done!"


    echo "Copying hardware config.."
    echo "{{hardware_config}}" | base64 -d > {{dir}}/machines/desktop_customised/hardware.nix
    echo "Done!"



# Build the configuration and show what would be activated
test: (_build-system "dry-activate")

# Build the configuration and put its result in ./result
build: (_build-system "build")

# Build and switch to the configuration
switch: (_build-system "switch")

# Build a VM out of the configuration
vm: (_build-system "build-vm")

# Clean up garbage from the nix store
clean:
    sudo nix-collect-garbage -d && sudo nix-store --optimise

# Upgrade the system
upgrade:
    nix flake update && sudo nixos-rebuild switch --flake "{{dir}}#{{system_name}}"

# Format the configuration
format:
    #! /usr/bin/env nix-shell
    #! nix-shell -i bash -p alejandra stylua
    alejandra -q .
    stylua .

# Edit the sops secrets stored in the config
secrets: 
    sops secrets.yaml
