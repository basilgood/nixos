{ stdenv, buildGoModule , fetchFromGitHub }:

buildGoModule rec {
  pname = "efm-langserver";
  version = "0.0.29";

  src = fetchFromGitHub {
    owner = "mattn";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-/G3GF4tz0MzR74aLKViKm03jT8e1MOzAjSpq9Aof5n8=";
  };

  vendorSha256 = "1whifjmdl72kkcb22h9b1zadsrc80prrjiyvyba2n5vb4kavximm";
}
