{ stdenv, fetchzip, unzip }:

stdenv.mkDerivation rec {
  name = "git-foresta";

  src = fetchzip {
    url =
      "https://github.com/takaaki-kasai/git-foresta/archive/v1.1.1.tar.gz";
    hash = "sha256-YJzmZuWQU2NTxTcs9l7VL53mdGqPmeZABVIUM90zrPg=";
  };

  patches = [./foresta.patch];

  installPhase = ''
    mkdir -p "$out/bin"
    cp git-foresta $out/bin/git-foresta
  '';
}
