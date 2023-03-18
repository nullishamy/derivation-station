self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: {
    version = "0.8.0";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "204a8b17c8ebab1619cc47a920a06dcc348d75f7";
      sha256 = "sha256-EZ60Qr4RT2bJwOHLoJq8jYJIGo/MoNmucy2pg7Lhx0A=";
    };
  });
}
