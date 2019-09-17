self: super:
let sentry = (import ./requirements.nix { pkgs = self; });
in sentry.mkDerivation {
  name = "sentry-9.1.2";
  src = ./.;

}
