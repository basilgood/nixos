self: super: {
  sentry = super.callPackage ./sentry.nix {
    inherit (super.python27.pkgs) buildPythonPackage fetchPypi;
    pythonPackages = super.python27.pkgs;
    semaphore = super.callPackage ./semaphore.nix {
      inherit (self) rustPlatform fetchFromGitHub cmake pkgconfig openssl bash;
      python = super.python27;
      geolite2-city = super.callPackage ./geolite2-city.nix {
        inherit (super) stdenv fetchurl gzip;
      };
    };
  };
}
