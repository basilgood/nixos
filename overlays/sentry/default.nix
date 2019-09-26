self: super:
let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/4ca0df15390.tar.gz";
    sha256 = "1ap9zchhm1vd8fpdfigigxx8qq5mk3nmpwddqjyzba7g4hm04i9y";
  }) { };
  sentryPython = pkgs.python27.override {
    packageOverrides = (python-self: python-super:
      {
        semaphore = python-super.callPackage ./semaphore.nix { };
        symbolic = python-super.callPackage ./symbolic.nix { };
        pkg-config = super.pkgconfig;
      } // (import ./overrides.nix) python-self python-super {
        inherit (pkgs) postgresql;
      });
  };
in { sentry = sentryPython.pkgs.callPackage ./sentry.nix { }; }
