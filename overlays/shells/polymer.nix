{ mkShell, nodejs-10_x, yarn, yarn-completion, chromedriver, sauce-connect
, google-chrome-beta , jdk11}:
let yarn-10_x = yarn.override { nodejs = nodejs-10_x; };
in mkShell {
  inputsFrom = [ yarn-10_x ];
  buildInputs = [ yarn-10_x  jdk11];
  shellHook = ''
    export XDG_DATA_DIRS=${yarn-completion}/share/:$XDG_DATA_DIRS
    export LAUNCHPAD_CHROME=${google-chrome-beta}/bin/google-chrome-beta

    link_executables () {
      if [ -d "./node_modules" ]; then
        ln -sfnv "${chromedriver}/bin/chromedriver" "$(find "./node_modules" -path '**/chromedriver/*-chromedriver')"
        ln -sfnv "${sauce-connect}/bin/sc" "$(find "./node_modules" -path '**/sauce-connect-launcher/sc/sc-*-linux/bin/sc')"
      fi
    }
    link_executables
  '';
}
