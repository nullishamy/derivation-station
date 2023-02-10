self: super:
{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: {
    version = "0.8.0";
    src = super.fetchFromGitHub {
    owner = "neovim";
    repo = "neovim";
    rev = "70fb40a2290d2a555a97d4aab33c813a0413da49";
    sha256 = "sha256-9W6laIPEeMupyuV/Rjt2bRtm86bV50USzWWLypdV6Jk=";
    };
  });

}
