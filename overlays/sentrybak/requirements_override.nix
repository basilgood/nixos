{ pkgs, python }:

self: super: {

  "poetry" = python.overrideDerivation super."poetry" (old: pkgs.python27Packages.poetry);

}
