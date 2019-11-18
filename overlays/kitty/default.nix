self: super:
{
  kitty = super.symlinkJoin {
    name = "kitty-with-config-${super.kitty.version}";

    paths = [ super.kitty ];
    nativeBuildInputs = [ super.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/kitty \
        --add-flags "--config ${./kitty.conf}" \
    '';
  };
}
