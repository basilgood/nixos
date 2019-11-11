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

  gv = pkgs.vimUtils.buildVimPlugin {
    name = "gv.vim";
    src = fetchFromGitHub {
      owner = "junegunn";
      repo = "gv.vim";
      rev = "7a84f6342cc79444e3fa873bf1d08fb6c53b097e";
      sha256 = "0q5xz8iw3jg42kbaspmgd8mlcgl3xglcqh3fyd2jmmwhnfzp3f7r";
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
      rev = "b6c8c8419240bdd29b5eb51a47d488fd390deed5";
      sha256 = "0p56av0zmig4rpsq4w4armnccyd713xdm5lwrck3cip55c39382f";
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

  vim-submode = pkgs.vimUtils.buildVimPlugin {
    name = "vim-submode";
    src = fetchFromGitHub {
      owner = "kana";
      repo = "vim-submode";
      rev = "d29de4f55c40a7a03af1d8134453a703d6affbd2";
      sha256 = "1qf0ryyjbv3yw916dnvqlzqvpskg2sbkwn46a2zph71p16sg6cp7";
    };
  };

  multiple = pkgs.vimUtils.buildVimPlugin {
    name = "vim-multiple-cursors";
    src = fetchFromGitHub {
      owner = "terryma";
      repo = "vim-multiple-cursors";
      rev = "6ab4dc7dd012e23adee74ef4596ad3e9659a20c7";
      sha256 = "149cg1fwsrd1swvd0ivn1p8j8gpj3gk08mx6dim4fkshknwxs5l0";
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

  jsonc = pkgs.vimUtils.buildVimPlugin {
    name = "jsonc.vim";
    src = fetchFromGitHub {
      owner = "neoclide";
      repo = "jsonc.vim";
      rev = "80da2a52db41b4c1ecf6f511422d3771e05622fa";
      sha256 = "1yix6dq1fh5nhwh5c1gr6z9d05ir5a2d0advdsli7n1y0cmwa8hr";
    };
  };

  nordish = pkgs.vimUtils.buildVimPlugin {
    pname = "nordish";
    version = "0.0.1";
    src = ./colors/nordish.vim;
    unpackCmd = ''
      mkdir -p out/colors;
      ln -s $curSrc out/colors/nordish.vim
      ls -al $curSrc
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
      ls -al $curSrc
    '';
    buildPhase = ":";
    configurePhase = ":";
  };
}
