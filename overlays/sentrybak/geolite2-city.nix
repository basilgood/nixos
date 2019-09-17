{stdenv, fetchurl, gzip}:
stdenv.mkDerivation rec {
  name = "GeoLite2-City.mmdb";
  src = fetchurl {
    url= "http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz";
    sha256 = "0wysqm3c8r2pgp90plkdwvc3dbcv56xgpxv2fx9r6hsfwj7wzf95";
  };
  unpackPhase = ''
    gzip -cfd $src > ${name}
  '';
  installPhase = ''
    mkdir $out
    cp -av GeoLite2-City.mmdb $out
  '';
}
