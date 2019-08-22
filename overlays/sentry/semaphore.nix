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
    cargoSha256 = "1s3hkf31zqkz7ni72b1kjq6i3626wqxbmncngf95w90w0kl4yhgh";
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
    mkdir -p rust/target/release
    cp ${native}/lib/libsemaphore.so rust/target/release/semaphore.so
    ls -al rust/target/release
  '';
  doCheck = false;
}
