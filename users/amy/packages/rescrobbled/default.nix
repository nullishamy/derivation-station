{
  lib,
  stdenvNoCC,
  rustPlatform,
  fetchFromGitHub,
  dbus,
  pkg-config,
  openssl,
}:
rustPlatform.buildRustPackage rec {
  pname = "rescrobbled";

  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "InputUsername";
    repo = "rescrobbled";
    rev = "v${version}";
    hash = "sha256-1E+SeKjHCah+IFn2QLAyyv7jgEcZ1gtkh8iHgiVBuz4=";
  };

  cargoSha256 = "sha256-ZJbyYFvGTuXt1aqhGOATcDRrkTk7SorWXkN81sUoDdo=";

  nativeBuildInputs = [pkg-config];
  buildInputs = [dbus.dev openssl.dev];

  checkFlags = [
    # Broken
    "--skip=filter::tests::test_filter_script"
  ];

  meta = with lib; {
    description = "MPRIS music scrobbler daemon";
    homepage = "https://github.com/InputUsername/rescrobbled";
    license = licenses.gpl3Only;
    platforms = platforms.x86_64;
    maintainers = with maintainers; [nullishamy];
  };
}
