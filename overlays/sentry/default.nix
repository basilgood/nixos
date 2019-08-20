self: super: {
  sentry = super.callPackage ./sentry.nix {
    inherit (super.python27.pkgs) buildPythonPackage fetchPypi;
    pythonPackages = super.python27.pkgs;
    inherit (super) fetchurl cargo rustc;
  };
}
