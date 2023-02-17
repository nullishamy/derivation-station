{
  lib,
  stdenv,
  fetchFromGitHub,
  unzip,
}:
stdenv.mkDerivation rec {
  pname = "catppuccin-gtk";
  version = "0.2.7";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "gtk";
    rev = "v-${version}";
    sha256 = "sha256-oTAfURHMWqlKHk4CNz5cn6vO/7GmQJM2rXXGDz2e+0w=";
  };

  buildInputs = [
    unzip
  ];

  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Releases/* $out/share/themes

    for theme in $out/share/themes/*.zip
    do
      theme_out=$(echo "$theme" | sed --expression "s/.zip//")
      unzip "$theme" -d "$theme_out"-tmp
      mv "$theme_out"-tmp/* $out/share/themes
      rm -rf "$theme_out"-tmp
    done

    rm $out/share/themes/*.zip
  '';

  meta = with lib; {
    description = "Catppuccin theme for GTK based desktop environments";
    homepage = "https://github.com/catppuccin/gtk";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    maintainers = [maintainers.nullishamy];
  };
}
