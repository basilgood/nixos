{ vimUtils, fetchFromGitHub, lib }:
let
  build = name: value: vimUtils.buildVimPlugin {
    name = value.name;
    src = fetchFromGitHub value.src;
  };

  plugins = builtins.fromJSON (builtins.readFile ./plugins.json);

in
lib.mapAttrs build plugins
