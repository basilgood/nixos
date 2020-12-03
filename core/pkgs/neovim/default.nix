{ lib
, callPackage
, vimPlugins
, vim-vint
, wrapNeovim
, neovim-unwrapped
, utf8proc
, makeWrapper
, fetchFromGitHub
, ripgrep
, fd
, fzf
, git
, tree-sitter
, nodePackages
, nixpkgs-fmt
, editorconfig-core-c
, python3Packages
}:
let
  # lsp = callPackage ./lsp {};
  # neovimConfig = callPackage ./config {};
  nvim = wrapNeovim (
    neovim-unwrapped.overrideAttrs (
      old: rec {
        version = "0.5.0";
        src = fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "a1a4dd34ea26d397f7222afe943f67bbdb889d3f";
          sha256 = "1d7i8087mjzbc9awqp3j0jr0pdn1k04kckml3wbbknws47fb27gx";
        };
        nativeBuildInputs = old.nativeBuildInputs ++ [ utf8proc tree-sitter makeWrapper ];
        postInstall = old.postInstall + ''
          wrapProgram $out/bin/nvim --prefix PATH : ${lib.makeBinPath
          [
            ripgrep
            fzf
            git
            fd
            nodePackages.eslint
            nodePackages.prettier
            nodePackages.typescript
            nodePackages.typescript-language-server
            nixpkgs-fmt
            vim-vint
            python3Packages.yamllint
            editorconfig-core-c
          ]
        }
        '';
      }
    )
  ) {
    withNodeJs = true;
    extraPython3Packages = [ python3Packages.neovim ];
    # inherit (neovimConfig) configure;
  };
in
nvim.overrideAttrs (
  old: rec {
    buildCommand = ''
      export HOME=$TMPDIR
    '' + old.buildCommand;
  }
)
