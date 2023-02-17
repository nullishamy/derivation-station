_: {
  # Pinentry / GPG
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  # Increase open file limits
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "8192";
    }
  ];

  # Enable yubikey support for the OS
  security.pam.yubico = {
    enable = true;
    mode = "challenge-response";
    control = "sufficient";
  };

  # Enable the pcscd daemon for smartcard support
  services.pcscd.enable = true;
}
