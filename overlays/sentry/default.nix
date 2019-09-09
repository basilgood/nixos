self: super:

let
  python = super.python27.override {
    packageOverrides = (python-self: python-super:
      {
        semaphore = python-super.callPackage ./semaphore.nix { };
        pkg-config = super.pkgconfig;
        openssl = super.openssl_1_0_2;
      } // (import ./overrides.nix) python-self python-super);
  };
in { sentry = python.pkgs.callPackage ./sentry.nix { }; }