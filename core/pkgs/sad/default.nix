{ rustPlatform, fetchFromGitHub, pkgconfig, glib }:
rustPlatform.buildRustPackage rec {
  pname = "sad";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "ms-jpq";
    repo = "sad";
    rev = "${version}";
    sha256 = "0qb6k41v5v2900ha9wpxd2lfknkj7g99gnxs345glkjxsvrjz2b0";
  };

  cargoPatches = [ ./add-Cargo.lock.patch ];
  cargoSha256 = "sha256-Ft+idVTQqZ2g4FBbUy+c+heVHnBBxi8KSHaq8D7MXAs";
  nativeBuildInputs = [
    pkgconfig
    # wrapGAppsHook
    glib # for glib-compile-resources
  ];

}
