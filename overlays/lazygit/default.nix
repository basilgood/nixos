self: super:
with super; {
  lazygit = lazygit.overrideAttrs (old: rec {
    name = "lazygit";
    src = fetchFromGitHub {
      owner = "jesseduffield";
      repo = "lazygit";
      rev = "710abded6416c51f72285854c332881efab3e810";
      sha256 = "06d7dz79gbd42ymqv48xlpxnhrri8mp4s0721ia410n0jxc56rsg";
    };
  });
}
