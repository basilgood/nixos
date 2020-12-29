{ neovim-unwrapped
, fetchFromGitHub
, tree-sitter
}:

neovim-unwrapped.overrideAttrs (
  old: rec {
    version = "0.5.0";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "bfed67e00ecdf71e0c7d17b1fd802f223b42c800";
      sha256 = "0g3syvb5c5qyl3l2b90fkxkwy9hsg8x2gmhblrmp7hw9lia0lg05";
    };
    buildInputs = old.buildInputs ++ [ tree-sitter ];
  }
)
