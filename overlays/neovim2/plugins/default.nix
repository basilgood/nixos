{ vimUtils, fetchFromGitHub, makeWrapper, callPackage }:
with vimUtils;

{
  vim-fugitive = buildVimPlugin {
    pname = "vim-fugitive";
    version = "0.1";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "b09c5d2523f9964add241a04862c2f8bbd7d428f";
      sha256 = "0x6j4z85z23wk1j7ni1558iyssiimixv26rhbsp9n26a4g8mm042";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  tcomment = buildVimPlugin {
    pname = "tcomment";
    version = "0.1";
    src = fetchFromGitHub {
      owner = "tomtom";
      repo = "tcomment_vim";
      rev = "c9cecefc639b6019e0f12b7e9fb5a2375cd550c1";
      sha256 = "0xb61wchvj1iqzwxzscv3zwbsx1qjh8qhkmijsrjz92566g12xhy";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  jsonc = buildVimPlugin {
    pname = "jsonc.vim";
    version = "2019-06-25";
    src = fetchFromGitHub {
      owner = "neoclide";
      repo = "jsonc.vim";
      rev = "80da2a52db41b4c1ecf6f511422d3771e05622fa";
      sha256 = "1yix6dq1fh5nhwh5c1gr6z9d05ir5a2d0advdsli7n1y0cmwa8hr";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  yats = buildVimPlugin {
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

  twig = buildVimPlugin {
    pname = "twig-vim";
    version = "0.1";
    src = fetchFromGitHub {
      owner = "lumiliet";
      repo = "vim-twig";
      rev = "ad115512725bcc156f7f89b72ff563b9fa44933b";
      sha256 = "1p7sfhk0mwx4xk88b29ijb9nfbjwsf6hf3nab2ybcw291qaa75nj";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  jsx = buildVimPlugin {
    pname = "vim-jsx-pretty";
    version = "2019-09-18";
    src = fetchFromGitHub {
      owner = "MaxMEllon";
      repo = "vim-jsx-pretty";
      rev = "89c30c0defe8ddb31bc0d3cfa5f22f3f6d8eb24f";
      sha256 = "1l5cwlbmihzxldpxlvn5gc47s0awqs908skzq43cy44iql829hir";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  gv = buildVimPlugin {
    pname = "gv.vim";
    version = "2019-04-2";
    src = fetchFromGitHub {
      owner = "junegunn";
      repo = "gv.vim";
      rev = "7a84f6342cc79444e3fa873bf1d08fb6c53b097e";
      sha256 = "0q5xz8iw3jg42kbaspmgd8mlcgl3xglcqh3fyd2jmmwhnfzp3f7r";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  vim-dispatch = buildVimPlugin {
    pname = "vim-dispatch";
    version = "0.8.0";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-dispatch";
      rev = "4bd1ecd7f38206ef26c37d7d142df58c4237d9dc";
      sha256 = "0wz8p8fm48dbpzd00h9qw0q2s3r7nm8qa5kcligcrzh1kv139026";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  vim-editorconfig = buildVimPlugin {
    pname = "vim-editorconfig";
    version = "0.8.0";
    src = fetchFromGitHub {
      owner = "sgur";
      repo = "vim-editorconfig";
      rev = "6b50f575752605f7e0a0e99e88be4129b2f99311";
      sha256 = "1kp82k3aympfhmdnfg45ynf3d5chs75ni740z5j05x6pgcj88rwz";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  fzf-vim = buildVimPlugin {
    pname = "fzf-vim";
    version = "2019-07-4";
    src = fetchFromGitHub {
      owner = "junegunn";
      repo = "fzf.vim";
      rev = "359a80e3a34aacbd5257713b6a88aa085337166f";
      sha256 = "0a01g0gw59m57zizidvm9n89qh8lvj0aq4kyxy27i72ysclp3wsf";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  wildfire = buildVimPlugin {
    pname = "wildfire.vim";
    version = "2014-10-16";
    src = fetchFromGitHub {
      owner = "gcmt";
      repo = "wildfire.vim";
      rev = "e2baded7162260e05d2527f5bca9fca81f0bc8f2";
      sha256 = "01i12x8brsnqicj5vclg57nv6ha7nz70gilphf6sr14xr741ra1y";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  cmdline = buildVimPlugin {
    pname = "cmdline-completion";
    version = "2014-04-10";
    src = fetchFromGitHub {
      owner = "sgur";
      repo = "cmdline-completion";
      rev = "34d03039b838fddc36a8ac75e4760d8e2835a5fb";
      sha256 = "0rjassl3l41ncdg2jyzawksinbp3pyf2g3vp8wvh0cxbmhabqjzg";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  vim-edgemotion = buildVimPlugin {
    pname = "vim-edgemotion";
    version = "2017-12-26";
    src = fetchFromGitHub {
      owner = "haya14busa";
      repo = "vim-edgemotion";
      rev = "8d16bd92f6203dfe44157d43be7880f34fd5c060";
      sha256 = "1w3nqkw7k2ryrw1rckj27a0jbjnvgc6fb7871fhb4ba2mpxd8l08";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  targets = buildVimPlugin {
    pname = "targets.vim";
    version = "2019-5-22";
    src = fetchFromGitHub {
      owner = "wellle";
      repo = "targets.vim";
      rev = "a79447f261e4b8b4327557aa03726f3849334b84";
      sha256 = "0x6a9rmv220kncjgak6aw3gbf3sidnj6nijphnsm5360lvi3ck4w";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  vim-startify = buildVimPlugin {
    pname = "vim-startify";
    version = "2019-10-1";
    src = fetchFromGitHub {
      owner = "mhinz";
      repo = "vim-startify";
      rev = "af03e075a3c0dfe5ca17fd49c59a3f4c30a4b342";
      sha256 = "1dd2vhszck76mpxz2m9qlmyvsravx9xslh4j68y8ygap97y2ykzi";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  vim-javascript = buildVimPlugin {
    pname = "vim-javascript";
    version = "2109-08-15";
    src = fetchFromGitHub {
      owner = "pangloss";
      repo = "vim-javascript";
      rev = "b6c8c8419240bdd29b5eb51a47d488fd390deed5";
      sha256 = "0p56av0zmig4rpsq4w4armnccyd713xdm5lwrck3cip55c39382f";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  vim-parenmatch = buildVimPlugin {
    pname = "vim-parenmatch";
    version = "2017-10-07";
    src = fetchFromGitHub {
      owner = "itchyny";
      repo = "vim-parenmatch";
      rev = "1a00e366a24f37ceaf8df87b5ff8bbd9f90e3758";
      sha256 = "00vkkq473qxzc6k1gmkbd91nqs81h0yszixpby3djwblg16fch75";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  vim-submode = buildVimPlugin {
    pname = "vim-submode";
    version = "2017-10-07";
    src = fetchFromGitHub {
      owner = "kana";
      repo = "vim-submode";
      rev = "d29de4f55c40a7a03af1d8134453a703d6affbd2";
      sha256 = "1qf0ryyjbv3yw916dnvqlzqvpskg2sbkwn46a2zph71p16sg6cp7";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  vim-twiggy = buildVimPlugin {
    pname = "vim-twiggy";
    version = "2019-9-06";
    src = fetchFromGitHub {
      owner = "sodapopcan";
      repo = "vim-twiggy";
      rev = "962b181f402f05b66641308fe1b3538d5f863ab8";
      sha256 = "0cqarsvdw9gr8pqp1gjy4rb6aaifjyb7iaaa2g8msr1ps0ihs3gd";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  vcs-jump = buildVimPlugin {
    pname = "vcs-jump";
    version = "2019-10-12";
    src = fetchFromGitHub {
      owner = "wincent";
      repo = "vcs-jump";
      rev = "a83cd2a6bfbf9356ee439a0e6aa29f8eaea4bb38";
      sha256 = "1n6g49pkf0qb2p5d845qgyndw3xh2ijzz8vm7lblsi9kb452bn7w";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  conflict3 = buildVimPlugin {
    pname = "conflict3";
    version = "2019-9-06";
    src = fetchFromGitHub {
      owner = "mkotha";
      repo = "conflict3";
      rev = "180e387fa464f27346db6a9c577ae6c1a26cd39a";
      sha256 = "027p8qd897q5p80cq95wwb3gln9jjjnzibsj8cd6bdsizy0cxcq7";
    };
    buildPhase = ":";
    configurePhase = ":";
  };

  all-func = buildVimPlugin {
    pname = "all-func";
    version = "0.0.1";
    src = ./functions.vim;
    unpackCmd = ''
      mkdir -p out/autoload;
      ln -s $curSrc out/autoload/functions.vim
      ls -al $curSrc
    '';
    buildPhase = ":";
    configurePhase = ":";
  };

  theonlyone = buildVimPlugin {
    pname = "theonlyone";
    version = "0.0.1";
    src = ./theonlyone.vim;
    unpackCmd = ''
      mkdir -p out/colors;
      ln -s $curSrc out/colors/theonlyone.vim
      ls -al $curSrc
    '';
    buildPhase = ":";
    configurePhase = ":";
  };

  apprentice = buildVimPlugin {
    pname = "apprentice-vim";
    version = "0.0.1";
    src = ./apprentice.vim;
    unpackCmd = ''
      mkdir -p out/colors;
      ln -s $curSrc out/colors/apprentice.vim
      ls -al $curSrc
    '';
    buildPhase = ":";
    configurePhase = ":";
  };
}
