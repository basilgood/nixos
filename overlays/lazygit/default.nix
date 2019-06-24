self: super:
with super; {
  lazygit = lazygit.overrideAttrs (old: rec {
    name = "lazygit";
    src = fetchFromGitHub {
      owner = "jesseduffield";
      repo = "lazygit";
      rev = "a68fb4fb8f7169b91f617c80deda177901c4202c";
      sha256 = "1g96bmj4i9w6qhwiz37igag8zgc1hy7qninplsq1qfbw54vycnnj";
    };
  });
}
