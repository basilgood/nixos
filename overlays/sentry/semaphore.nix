{ rustPlatform, fetchFromGitHub, cmake, pkgconfig, openssl, python, bash
, geolite2-city }:
with rustPlatform;
let rpathLibs = [ openssl ];
in buildRustPackage rec {
  pname = "semaphore";
  version = "0.4.42";

  src = fetchFromGitHub {
    owner = "getsentry";
    repo = pname;
    rev = "${version}";
    sha256 = "1l903q5w6p6jz9xy8120fdv67479vvrzxx5ssnnqiwmd6lmb7ps6";
    fetchSubmodules = true;
  };

  cargoSha256 = "1s3hkf31zqkz7ni72b1kjq6i3626wqxbmncngf95w90w0kl4yhgh";
  nativeBuildInputs = [ cmake pkgconfig python.pkgs.virtualenv ];
  buildInputs = [ rpathLibs x86_64-unknown-linux-gnu ];
  propagatedBuildInputs = [ python.pkgs.milksnake ];

  buildPhase = ''
    set +x
    ls -al ${geolite2-city}/
    mkdir -p .git/hooks/
    ls -al general/uap-core
    substituteInPlace Makefile  \
      --replace /bin/bash ${bash}/bin/bash \
      --replace "setup: setup-geoip setup-git setup-venv" "setup: setup-geoip setup-venv" \
      --replace '@which virtualenv || sudo easy_install virtualenv' "" \
      --replace 'python3' ${python.interpreter} \
      --replace '+stable' "" \
      --replace '@curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz | gzip -cd > $@' "cp ${geolite2-city}/GeoLite2-City.mmdb ./"
    cat Makefile
    make release
    ls -al
  '';
}
