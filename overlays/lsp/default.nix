self: super:
{
  lspPackages = import ./node-packages.nix {
    inherit (super) fetchurl fetchgit;
    nodeEnv = (import <nixpkgs/pkgs/development/node-packages/node-env.nix> {
      inherit (super) stdenv python2 utillinux runCommand writeTextFile;
      inherit (super) nodejs;
      libtool = null;
    });
  };
}
