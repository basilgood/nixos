{ neovim-unwrapped
, tree-sitter
, buildEnv
, nodePackages
, nixpkgs-fmt
, luaformatter
, shfmt
, vim-vint
, luajitPackages
, yamllint
, fzf
, fd
, ripgrep
, wl-clipboard
}:
let
  _nvim = neovim-unwrapped.overrideAttrs (oa: {
    version = "master";

    src = builtins.fetchGit {
      url = https://github.com/neovim/neovim.git;
    };

    nativeBuildInputs = neovim-unwrapped.nativeBuildInputs ++ [ tree-sitter ];
  });
in
buildEnv {
  name = "nvim";
  paths = [
    _nvim
    wl-clipboard
    fzf
    fd
    ripgrep
    nodePackages.prettier
    nodePackages.typescript-language-server
    nixpkgs-fmt
    luaformatter
    shfmt
    vim-vint
    yamllint
    luajitPackages.luacheck
  ];
}
