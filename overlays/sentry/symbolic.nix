{ rustPlatform, fetchFromGitHub, fetchPypi, pkg-config, cmake, openssl
, buildPythonPackage, milksnake, setuptools_scm }:

buildPythonPackage rec {
  pname = "symbolic";
  version = "6.1.4";

  name = "${pname}-${version}";
  src = fetchPypi {
    inherit pname version;
    sha256 = "145p1xjw0njly4wsxk75hswj4q4w0f2kh62cf0bqg4jkl8byi4ak";
    extension = "zip";
  };

  native = rustPlatform.buildRustPackage {
    name = "${name}-native";
    src = fetchFromGitHub {
      owner = "getsentry";
      repo = pname;
      rev = "${version}";
      sha256 = "1sy4sggbsscyki093qz48hd5ywk1bp7ymajgqs0agic5ppv7c01z";
      fetchSubmodules = true;
    };
    sourceRoot = "source/cabi";
    cargoSha256 = "1fl9j8a6gh49r84rw1hpwwikjni6d8g5mmc7zhkjdix7w4c6zh56";
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ openssl ];
    postInstall = ''
      mkdir -p $out/include
      cp include/symbolic.h $out/include/
    '';
    doCheck = false;
  };

  propagatedBuildInputs = [ milksnake setuptools_scm ];

  patches = [ ./symbolic.patch ];

  preBuild = ''
    mkdir -p rust/target/release rust/include
    cp ${native}/lib/libsymbolic.so rust/target/release/libsymbolic.so
    cp ${native}/include/symbolic.h rust/include/symbolic.h
  '';
  doCheck = false;
}
