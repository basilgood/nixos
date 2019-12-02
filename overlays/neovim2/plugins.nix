{ self, super }:
with super;

{

  vim-fugitive = pkgs.vimUtils.buildVimPlugin {
    name = "vim-fugitive";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "f6acae50ea4d8ec1bb1497cb886d80298b54831b";
      sha256 = "04k9bmqzlrx9pvkjs51znbbrqxy416k6jl7ffdp892hacgvr8cnj";
    };
  };

  conflicted = pkgs.vimUtils.buildVimPlugin {
    name = "vim-conflicted";
    src = fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-conflicted";
      rev = "4762e1a85e24f43a40fb218c1e906554ce4c63c3";
      sha256 = "1m0lv0wxg72bg0nzlim2jcnqn8gzancgzwrxf2i6gx7jb2dckzv9";
    };
  };

  skim-vim = pkgs.vimUtils.buildVimPlugin {
    name = "skim-vim";
    src = fetchFromGitHub {
      owner = "lotabout";
      repo = "skim.vim";
      rev = "4e9d9a3deb2060e2e79fede1c213f13ac7866eb5";
      sha256 = "0vpfn2zivk8cf2l841jbd78zl1vzdw1wjf9p0dm6pgr84kj9pkx4";
    };
  };

  actionmenu = pkgs.vimUtils.buildVimPlugin {
    name = "actionmenu.nvim";
    src = fetchFromGitHub {
      owner = "kizza";
      repo = "actionmenu.nvim";
      rev = "167829ee307c831db6927b931a56eadec8b96e97";
      sha256 = "0cp63wkixfw2xsn4pi4q0wx0wxb0pms5f0xjlkv2j172g6xyamff";
    };
  };

  vim-javascript = pkgs.vimUtils.buildVimPlugin {
    name = "vim-javascript";
    src = fetchFromGitHub {
      owner = "pangloss";
      repo = "vim-javascript";
      rev = "2e4a8c485cdf601bb2f2761ea68c09750a0b82e0";
      sha256 = "1zvqpk8qvkhglfdi6ma7ads54w0i8v8vy4k3gcrrjydmwwa2v34l";
    };
  };

  yats = pkgs.vimUtils.buildVimPlugin {
    pname = "yats-vim";
    version = "0.1";
    src = fetchFromGitHub {
      owner = "HerringtonDarkholme";
      repo = "yats.vim";
      rev = "d9af5fc9fd7f11fa1219a9acb6f4243105e60b38";
      sha256 = "0dqd9s0s8xvr9yh33ycncfd0y1nlsfh64azb8f92bggx5plkji2r";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  twig = pkgs.vimUtils.buildVimPlugin {
    name = "twig-vim";
    src = fetchFromGitHub {
      owner = "lumiliet";
      repo = "vim-twig";
      rev = "ad115512725bcc156f7f89b72ff563b9fa44933b";
      sha256 = "1p7sfhk0mwx4xk88b29ijb9nfbjwsf6hf3nab2ybcw291qaa75nj";
    };
  };

  jsx = pkgs.vimUtils.buildVimPlugin {
    name = "vim-jsx-pretty";
    src = fetchFromGitHub {
      owner = "MaxMEllon";
      repo = "vim-jsx-pretty";
      rev = "89c30c0defe8ddb31bc0d3cfa5f22f3f6d8eb24f";
      sha256 = "1l5cwlbmihzxldpxlvn5gc47s0awqs908skzq43cy44iql829hir";
    };
  };

  jsonc = pkgs.vimUtils.buildVimPlugin {
    name = "jsonc.vim";
    src = fetchFromGitHub {
      owner = "neoclide";
      repo = "jsonc.vim";
      rev = "80da2a52db41b4c1ecf6f511422d3771e05622fa";
      sha256 = "1yix6dq1fh5nhwh5c1gr6z9d05ir5a2d0advdsli7n1y0cmwa8hr";
    };
  };

  multiple-cursors = pkgs.vimUtils.buildVimPlugin {
    name = "vim-multiple-cursors";
    src = fetchFromGitHub {
      owner = "terryma";
      repo = "vim-multiple-cursors";
      rev = "6ab4dc7dd012e23adee74ef4596ad3e9659a20c7";
      sha256 = "149cg1fwsrd1swvd0ivn1p8j8gpj3gk08mx6dim4fkshknwxs5l0";
    };
  };

  targets = pkgs.vimUtils.buildVimPlugin {
    name = "targets.vim";
    src = fetchFromGitHub {
      owner = "wellle";
      repo = "targets.vim";
      rev = "a79447f261e4b8b4327557aa03726f3849334b84";
      sha256 = "0x6a9rmv220kncjgak6aw3gbf3sidnj6nijphnsm5360lvi3ck4w";
    };
  };

  wildfire = pkgs.vimUtils.buildVimPlugin {
    name = "wildfire.vim";
    src = fetchFromGitHub {
      owner = "gcmt";
      repo = "wildfire.vim";
      rev = "e2baded7162260e05d2527f5bca9fca81f0bc8f2";
      sha256 = "01i12x8brsnqicj5vclg57nv6ha7nz70gilphf6sr14xr741ra1y";
    };
  };

  vcs-jump = pkgs.vimUtils.buildVimPlugin {
    name = "vcs-jump";
    src = fetchFromGitHub {
      owner = "wincent";
      repo = "vcs-jump";
      rev = "a83cd2a6bfbf9356ee439a0e6aa29f8eaea4bb38";
      sha256 = "1n6g49pkf0qb2p5d845qgyndw3xh2ijzz8vm7lblsi9kb452bn7w";
    };
  };

  conflict-marker = pkgs.vimUtils.buildVimPlugin {
    name = "conflict-marker.vim";
    src = fetchFromGitHub {
      owner = "da-x";
      repo = "conflict-marker.vim";
      rev = "9b7c67715d13a18ba0abd2d81b393dc8d458a3fb";
      sha256 = "03sfhb182bwz0gy3ksn4i6850cncc9l3b0cmfpfl6a642fl7xi3v";
    };
  };

  vim-edgemotion = pkgs.vimUtils.buildVimPlugin {
    name = "vim-edgemotion";
    src = fetchFromGitHub {
      owner = "haya14busa";
      repo = "vim-edgemotion";
      rev = "8d16bd92f6203dfe44157d43be7880f34fd5c060";
      sha256 = "1w3nqkw7k2ryrw1rckj27a0jbjnvgc6fb7871fhb4ba2mpxd8l08";
    };
  };

  cool = pkgs.vimUtils.buildVimPlugin {
    name = "vim-cool";
    src = fetchFromGitHub {
      owner = "romainl";
      repo = "vim-cool";
      rev = "06918c36b3396af0bec1e87e748a5dba55be87b9";
      sha256 = "099sbjdk944bnivqgqgbjplczfm3k84583ryrmpqf3lgrq6pl8wr";
    };
  };

  ags = pkgs.vimUtils.buildVimPlugin {
    name = "vim-ags";
    src = fetchFromGitHub {
      owner = "gabesoft";
      repo = "vim-ags";
      rev = "22578799d437f674760d02cd25cfdb9bea0d93fb";
      sha256 = "0v9dhnccr691hva6567r60fnkf2lv8ivz39h4h1qriz8jwg62xc9";
    };
  };

  vim-editorconfig = pkgs.vimUtils.buildVimPlugin {
    name = "vim-editorconfig";
    src = fetchFromGitHub {
      owner = "sgur";
      repo = "vim-editorconfig";
      rev = "6b50f575752605f7e0a0e99e88be4129b2f99311";
      sha256 = "1kp82k3aympfhmdnfg45ynf3d5chs75ni740z5j05x6pgcj88rwz";
    };
  };

  vim-parenmatch = pkgs.vimUtils.buildVimPlugin {
    name = "vim-parenmatch";
    src = fetchFromGitHub {
      owner = "itchyny";
      repo = "vim-parenmatch";
      rev = "1a00e366a24f37ceaf8df87b5ff8bbd9f90e3758";
      sha256 = "00vkkq473qxzc6k1gmkbd91nqs81h0yszixpby3djwblg16fch75";
    };
  };

  cmdline = pkgs.vimUtils.buildVimPlugin {
    name = "cmdline-completion";
    src = fetchFromGitHub {
      owner = "sgur";
      repo = "cmdline-completion";
      rev = "34d03039b838fddc36a8ac75e4760d8e2835a5fb";
      sha256 = "0rjassl3l41ncdg2jyzawksinbp3pyf2g3vp8wvh0cxbmhabqjzg";
    };
  };

  nordish = pkgs.vimUtils.buildVimPlugin {
    pname = "nordish";
    version = "0.0.1";
    src = ./colors/nordish.vim;
    unpackCmd = ''
      mkdir -p out/colors;
      ln -s $curSrc out/colors/nordish.vim
    '';
    buildPhase = ":";
    configurePhase = ":";
  };

  allfunc = pkgs.vimUtils.buildVimPlugin {
    pname = "allfunc";
    version = "0.0.1";
    src = ./allfunc/functions.vim;
    unpackCmd = ''
      mkdir -p out/autoload;
      ln -s $curSrc out/autoload/functions.vim
    '';
    buildPhase = ":";
    configurePhase = ":";
  };

  # allfunc = opt_plugins: pkgs.vimUtils.buildVimPlugin {
  #   pname = "allfunc";
  #   version = "0.0.1";
  #   src = pkgs.writeText "functions.vim" ''
  #     ${pkgs.readFile ./allfunc/functions.vim}
  #     func packaddhandler
  #     ${pkgs.lib.map opt_plugins ({name}: "execute 'packadd ${name}'") }
  #     endfunc
  #   '';
  #   unpackCmd = ''
  #     mkdir -p out/autoload;
  #     ln -s $curSrc out/autoload/functions.vim
  #   '';
  #   buildPhase = ":";
  #   configurePhase = ":";
  # };
}
