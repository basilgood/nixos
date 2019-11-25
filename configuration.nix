{ config, lib, pkgs, ... }:

{
  imports = [
    ./local.nix
    ./hardware-configuration.nix
    ./modules/base.nix
    ./modules/hardware/ssd.nix
    ./modules/hardware/zram.nix
    ./modules/fonts
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "plumfive";

  powerManagement.cpuFreqGovernor = "ondemand";

  users.defaultUser = {
    name = "vasy";
    packages = with pkgs; [
      kak
      kitty
      skim
      aspell
      aspellDicts.en
      nodejs-10_x
      spotify
      plumelo
      vim-vint
      python27Packages.yamllint
      editorconfig-core-c
      nixfmt
      neovim2
      vifm
      mc
      feh
      mupdf
    ];
  };

  programs.git.enable = true;
  programs.git.lfsEnable = true;
  programs.git.name = "vasile luta";
  programs.git.email = "elsile69@yahoo.com";
  programs.git.editor = "${pkgs.vim}/bin/vim";
  programs.git.pager =
    "${pkgs.gitAndTools.diff-so-fancy}/bin/diff-so-fancy | ${pkgs.less}/bin/less --tabs=1,5 -XFR";
  programs.git.extraConfig = "";
  programs.git.difftool = "vim";
  programs.git.mergetool = "vim";
  programs.git.interface = pkgs.gitAndTools.tig;
  programs.git.extraPackages = with pkgs; [gitAndTools.git-imerge];

  programs.sway = {

    enable = true;

    extraConfig = ''
      output * bg ${./wall.jpg} fill
    '';

    terminal = "${pkgs.kitty}/bin/kitty";

  };

  programs.tmux.enable = true;

  virtualisation = {
    lxc = {
      enable = true;
      lxcfs.enable = true;
      net.enable = true;
    };
    lxd.enable = true;
    # virtualbox.host.enable = true;
  };

  environment.variables = let neovim = "${pkgs.neovim2}/bin/nvm";
  in {
    EDITOR = neovim;
    VISUAL = neovim;
  };

  services = {
    redshift.enable = true;
    syncthing.enable = true;
  };
}
