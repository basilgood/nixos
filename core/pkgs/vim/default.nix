{ vim_configurable
, python3
, lib
, nodePackages
, nixpkgs-fmt
, vim-vint
, shfmt
, wl-clipboard
, fzf
, fd
, ripgrep
, git
, buildEnv
, fetchFromGitHub
}:

let
  _vim = ((vim_configurable.overrideAttrs (oldAttrs: rec {
    version = "8.2.2995";
    src = fetchFromGitHub {
      owner = "vim";
      repo = "vim";
      rev = "v${version}";
      hash = "sha256-1bchQOkCYow2t64dN/tUr4Q7GESJaLrOd3p4HtmFE2o=";
    };
  })).override {
    ftNixSupport = false;
  }).customize {
    name = "vim";
    vimrcConfig.customRC = builtins.readFile ./vimrc;

    vimrcConfig.packages.myVimPackage = {};
  };
in
buildEnv {
  name = "vim";
  paths = [
    _vim
    python3
    wl-clipboard
    fzf
    fd
    ripgrep
    git
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nixpkgs-fmt
    shfmt
    vim-vint
  ];
}
