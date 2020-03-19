{ lib
, callPackage
, vimPlugins
, vim-vint
, wrapNeovim
, neovim-unwrapped
, utf8proc
, makeWrapper
, fetchFromGitHub
, ag
, ripgrep
, fd
, fzf
, git
, nodePackages
, nixpkgs-fmt
, shfmt
, editorconfig-core-c
, python37Packages
, python27Packages
, rnix-lsp
}:
let
  lsp = callPackage ./lsp { };
  neovimConfig = callPackage ./config { };
  neovim = wrapNeovim
    (
      neovim-unwrapped.overrideAttrs (
        old: rec {
          name = "neovim-unwrapped-${version}";
          version = "nightly";
          src = fetchFromGitHub {
            owner = "neovim";
            repo = "neovim";
            rev = "1ca67a73c0ba680eb8328e68bea31f839855dd29";
            hash = "sha256-wlbtWKYd2PSlwhJgfK4DiJTbSCyASUaZ683aW3tpyJQ=";
          };
          nativeBuildInputs = old.nativeBuildInputs ++ [ utf8proc makeWrapper ];
          postInstall = old.postInstall + ''
            wrapProgram $out/bin/nvim --prefix PATH : ${lib.makeBinPath [
              ripgrep
              fzf
              git
              fd
              lsp.vim-language-server
              lsp.fixjson
              lsp.jsonlint
              nodePackages.eslint
              nodePackages.prettier
              nodePackages.typescript
              nodePackages.typescript-language-server
              nixpkgs-fmt
              shfmt
              vim-vint
              python37Packages.yamllint
            ]
            }
          '';
        }
      )
    ) {
    withNodeJs = true;
    extraPython3Packages = pythonPackages: [ pythonPackages.pynvim ];
    inherit (neovimConfig) configure;
  };
in
neovim.overrideAttrs (
  old: rec {
    buildCommand = ''
      export HOME=$TMPDIR
    '' + old.buildCommand;
  }
)
