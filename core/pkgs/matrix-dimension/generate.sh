#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nodePackages.node2nix
node2nix \
  --nodejs-10 \
  --development \
  -l package-lock.json \
  -o node-packages.nix \
  -c node.nix \
  -e "<nixpkgs/pkgs/development/node-packages/node-env.nix>" \
  --no-copy-node-env
