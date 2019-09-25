self: super:

let
  python = super.python27.override {
    packageOverrides = (python-self: python-super:
      {
        semaphore = python-super.callPackage ./semaphore.nix { };
        symbolic = python-super.callPackage ./symbolic.nix { };
        pkg-config = super.pkgconfig;
        #openssl = super.openssl_1_0_2;
      } // (import ./overrides.nix) python-self python-super {
        inherit (super) postgresql;
      });
  };
in { sentry = python.pkgs.callPackage ./sentry.nix { }; }
