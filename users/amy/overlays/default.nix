self: super:
{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: {
    version = "0.9.0-nightly";
    src = super.fetchFromGitHub {
    owner = "neovim";
    repo = "neovim";
    rev = "8144deb0989ea5c61fe9a1a5802d230eba33dfdd";
    sha256 = "sha256-R8j3d0FuHWMKCpIw0y5c6+m5dffAFgPNiTLV46x6IEQ=";
    };
  });
}
