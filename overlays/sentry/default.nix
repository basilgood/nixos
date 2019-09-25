self: super:
#let python = import ./requirements.nix { pkgs = super; };
#in { sentry = python.packages.sentry; }
{}

