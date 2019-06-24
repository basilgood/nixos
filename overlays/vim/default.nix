self: super:
with super; {
  vimHugeX = (vimHugeX.overrideAttrs (oldAttrs: rec {
    name = "vim-${version}";
    version = "8.1.2016";

    src = fetchFromGitHub {
      owner = "vim";
      repo = "vim";
      rev = "v${version}";
      sha256 = "1wpp5ndg66sjgxwa6mzhpvn4snn6ri441mfz1n9sr7zkv6fk8cy7";
    };
  })).override { python = python3; };
}
