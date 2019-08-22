self: super:
let
  callPackage = (super.python27.override {
    packageOverrides = (pyton-self: python-super: {
      semaphore = python-super.callPackage ./semaphore.nix { };
      pkg-config = super.pkgconfig;
    });
  }).pkgs.callPackage;
in { sentry = callPackage ./sentry.nix { }; }
