{ config, pkgs, ... }:

# Gruvbox resources: https://www.reddit.com/r/gruvbox/comments/np5ylp/official_resources/

let
  imports = [ 
    ../apps/rofi.nix
    ../apps/polybar.nix
    ../apps/flameshot.nix
    ../apps/zsh.nix
    ../apps/gtk.nix
    ../apps/chromium.nix
    ../apps/alacritty.nix
    ../apps/i3.nix
    ../apps/git.nix
    ../apps/keybase.nix
    ../apps/xdg.nix
    ../apps/lazygit.nix
  ];
in {
  inherit imports;
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "amy";
    homeDirectory = "/home/amy";

    # ENV vars
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "neovide";
      TERMINAL = "alacritty";
    };

    packages = with pkgs; [ 
      bottom neofetch gh rofi discord spotifywm flameshot
      lazygit keybase go nodejs luarocks gcc neovide
      bitwarden cargo gparted gimp ripgrep 
      steam protonvpn-gui lunar-client jdk 
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";
  };

  programs = {
    home-manager = {
      # Let Home Manager install and manage itself.
      enable = true;
    };
  };
}
