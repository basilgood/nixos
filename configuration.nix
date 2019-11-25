{ config, lib, pkgs, ... }: {
  imports = [ ./local.nix ./hardware-configuration.nix ./modules/base.nix ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  powerManagement.cpuFreqGovernor = "ondemand";

  users.defaultUser = {
    name = "vasy";
    packages = with pkgs; [
      kak
      kitty
      skim
      nodejs-10_x
      spotify
      plumelo
      vim-vint
      python27Packages.yamllint
      editorconfig-core-c
      nixfmt
      neovim2
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

  networking.hostName = "plumfive";

  programs.sway = {

    enable = true;

    extraPackages = [ pkgs.numix-gtk-theme ];

    extraConfig = ''
      output * bg ${./modules/programs/sway/wall1.jpg} fill
    '';

    terminal = "${pkgs.kitty}/bin/kitty";

  };

  virtualisation = {
    lxc = {
      enable = true;
      lxcfs.enable = true;
      net.enable = true;
    };
    lxd.enable = true;
    # virtualbox.host.enable = true;
  };

  environment.variables = let vim = "${pkgs.vim}/bin/vim";
  in {
    EDITOR = vim;
    VISUAL = vim;
  };
}
