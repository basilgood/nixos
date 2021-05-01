{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "git-foresta";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "takaaki-kasai";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-YJzmZuWQU2NTxTcs9l7VL53mdGqPmeZABVIUM90zrPg=";
  };

  installPhase = ''
    install -D -m 0755 git-foresta $out/bin/git-foresta
  '';

  meta = with lib; {
    description = "Text-based git log graph viewer";
    homepage = "https://github.com/takaaki-kasai/git-foresta.git";
    maintainers = with maintainers; [ moi ];
  };
}
