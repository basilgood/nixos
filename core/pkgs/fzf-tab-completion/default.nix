{ stdenv, fetchzip, unzip }:

stdenv.mkDerivation rec {
  name = "fzf-tab-completion";

  src = fetchzip {
    url =
      "https://github.com/lincheney/fzf-tab-completion/archive/527ac6ce7c7512a4d261484e2426f8a85588cf30.tar.gz";
    hash = "sha256-xpHOoH55q2E4NJba5SCSmVTu/BEUVTC1ZONG0T2gojE=";
  };

  installPhase = ''
    mkdir -p "$out"
    pushd bash
    cp fzf-bash-completion.sh $out/fzf-bash-completion.sh
    popd
  '';
}
