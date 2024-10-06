{
  pkgs,
  config,
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
    bottom
    neofetch
    gh
    thunderbird
    comma
    rofi
    spotifywm
    flameshot
    keybase
    neovide
    discord
    discord-canary
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
