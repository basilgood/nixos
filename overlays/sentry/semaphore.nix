{ rustPlatform, fetchFromGitHub, fetchPypi, pkg-config, cmake, openssl
, buildPythonPackage, milksnake, setuptools_scm, }:

buildPythonPackage rec {
  pname = "semaphore";
  version = "0.4.42";
  name = "${pname}-${version}";
  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    sha256 = "0z7z1j6qn2k14lyqkdrwvvv531zyfdc0zc3g7b2d20mjgcvsxgb0";
  };
  native = rustPlatform.buildRustPackage {
    name = "${name}-native";
    src = fetchFromGitHub {
      owner = "getsentry";
      repo = pname;
      rev = "${version}";
      sha256 = "1l903q5w6p6jz9xy8120fdv67479vvrzxx5ssnnqiwmd6lmb7ps6";
      fetchSubmodules = true;
    };
    sourceRoot = "source/cabi";
    cargoSha256 = "0723h8qcbg6yqsmxw4wmbdvq5jf70h8g0xminar06p0hrz4l3sx3";
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ openssl ];
    postInstall = ''
      mkdir -p $out/include
      cp include/semaphore.h $out/include/
    '';
    doCheck = false;
  };

  propagatedBuildInputs = [ milksnake setuptools_scm ];

  patches = [ ./semaphore.patch ];

  preBuild = ''
    ls -al ${native}
    mkdir -p rust/target/release rust/include
    cp ${native}/lib/libsemaphore.so rust/target/release/libsemaphore.so
    cp ${native}/include/semaphore.h rust/include/semaphore.h
    ls -al rust/target/release
  '';
  doCheck = false;
}
