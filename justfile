system_name := "nixon"

# HACK: Use b64 because bash is dumb and stupid
# HACK: Redirect stderr to /dev/null because nixos is dumb and stupid
hardware_config :=  `sudo nixos-generate-config --show-hardware-config 2>/dev/null | base64 -w0`
dir := justfile_directory()

_default:
  @just --list

_build-system type:
    sudo nixos-rebuild {{type}} --flake "{{dir}}#{{system_name}}"

# Setup the OS for the first time
setup:
    #!/usr/bin/env bash

    if [[ -d "{{dir}}/machines/desktop_customised" ]]; then
        echo "ERROR: Setup has already completed (custom desktop dir exists)" && exit 1
    fi

    echo {{dir}}
    mkdir -p "{{dir}}/machines/desktop_customised"
    cp -r "{{dir}}/machines/desktop/"* "{{dir}}/machines/desktop_customised"
    echo "{{hardware_config}}" | base64 -d > {{dir}}/machines/desktop_customised/hardware.nix

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
    sudo nixos-rebuild switch --upgrade

# Format the configuration
format:
    #! /usr/bin/env nix-shell
    #! nix-shell -i bash -p alejandra stylua
    alejandra -q .
    stylua .

# Edit the sops secrets stored in the config
secrets: 
    sops secrets.yaml
