{
  pkgs,
  config,
  ghostty,
  ...
}: {
  imports = [
    ./dedicated
    ./personal
    ./service
    ./system
    ./tools
    ./ui
  ];

  home.packages = with pkgs; [
    ghostty.packages.x86_64-linux.default
    bottom
    neofetch
    gh
    thunderbird
    comma
    rofi
    spotifywm
    flameshot
    keybase
    pkgs.unstable.neovide
    vesktop
    _1password-gui
    gparted
    gimp
    obsidian
    steam
    lunar-client
    pavucontrol
    photoqt
    dunst
    tailscale

    element-desktop

    # 3D printing
    #super-slicer

    # Modern unix
    ripgrep
    fd
    duf
    jq
    dogdns

    jetbrains.idea-community
  ];
}
