_: {
  # Hardware configuration
  hardware = {
    bluetooth = {
      enable = true;
    };
  };

  # Blueman
  services.blueman = {
    enable = true;
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
