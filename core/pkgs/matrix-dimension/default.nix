{ fetchFromGitHub
, makeWrapper
, vips
, nodePackages
, nodejs
, pkg-config
, buildEnv
, writeText
, runtimeShell
}:
let
  runtimeEnv = buildEnv {
    name = "matrix-dimension";
    paths = [
      nodejs
    ];
  };

  # executableScript = writeText "matrix-dimension" ''
  #   ${nodejs}/bin/node build/app/index.js
  # '';
in
(import ./node.nix { }).package.override {
  src = fetchFromGitHub {
    owner = "turt2live";
    repo = "matrix-dimension";
    rev = "9e2393cecac3aabdc3d6d7236a4c139d6fe9ff6d";
    sha256 = "6dc9d2fe20d42adeca0134283a026fbed4158f47a9b87dce3af5e97e85e88952";
  };

  nativeBuildInputs = [ makeWrapper pkg-config ];

  buildInputs = [
    vips
    nodePackages.node-pre-gyp
  ];

  postInstall = ''
    substituteInPlace $out/lib/node_modules/matrix-dimension/webpack.config.js \
    --replace "}, 'angular2-template-loader', '@angularclass/hmr-loader'],"  "}, 'angular2-template-loader', '@angularclass/hmr-loader']" \
    --replace "exclude: [/node_modules\/(?!(ng2-.+))/]" ""
    patchShebangs --build "$out/lib/node_modules/matrix-dimension/node_modules/"
    npm run build
    mkdir -p $out/bin
    cat >$out/bin/matrix-dimension <<EOF
      #!${runtimeShell}
      ${nodejs}/bin/node $out/lib/node_modules/matrix-dimension/build/app/index.js
    EOF
  '';

  postFixup = ''
    chmod +x $out/bin/matrix-dimension
    wrapProgram $out/bin/matrix-dimension \
      --set NODE_PATH "${runtimeEnv}/lib/node_modules"
  '';
}
