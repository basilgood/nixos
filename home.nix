{ pkgs, ... }:
with pkgs;
{
  home.packages = [
    keepassxc
    parsec-client
    element-desktop
    thunderbird
    xdg_utils
    vimHugeX
    tmate
    nodePackages.diagnostic-languageserver
    brave
    imv
    atool
    mediainfo
    mp3info
    mplayer
    audio-recorder
    archivemount
    archiver
    fd
    bashmount
    cmus
    lazygit
    gitAndTools.gitui
    youtubeDL
    ffmpeg
    chromedriver
    geckodriver
  ];

  programs.chromium.enable = true;
  programs.firefox.enable = true;
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude node_modules";
    defaultOptions = [ "--layout=reverse" ];
  };
  programs.bat = {
    enable = true;
    config.theme = "base16";
  };
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    scripts = [ pkgs.mpvScripts.mpris ];
  };

  xdg.enable = true;
  programs.password-store = {
    enable = true;
    package = pkgs.pass-wayland.withExtensions (exts: [ exts.pass-otp ]);
    settings = { PASSWORD_STORE_DIR = "$HOME/.local/share/password-store"; };
  };

  wayland.windowManager.sway = {
    config = {
      keybindings = lib.mkOptionDefault {
        "Mod4+i" = "exec swaymsg inhibit_idle open";
        "Mod4+Shift+i" = "exec swaymsg inhibit_idle none";
      };
    };
    extraConfig = ''
      bindswitch --reload lid:on  output eDP-1 disable
      bindswitch --reload lid:off output eDP-1 enable
      # output * bg #1e1c31 solid_color
      output * bg ~/Projects/nixos/mclaren.jpeg fill
      output "Samsung Electric Company SAMSUNG 0x00000F00" mode 4096x2160@60Hz scale_filter smart scale 1.5
      output "Goldstar Company Ltd LG ULTRAWIDE 0x0000BF93" mode 2560x1080@59.978001Hz scale_filter smart scale 1.1
      for_window [class="^.*"] inhibit_idle fullscreen
    '';
  };

  home.sessionVariables = rec {
    VISUAL = "nvim";
    EDITOR = VISUAL;
  };

  services.syncthing.enable = true;

  services.wlsunset  = {
    enable = true;
    latitude = "47.15";
    longitude = "27.59";
    temperature.day = 5500;
    temperature.night = 3700;
  };
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };

  # git
  programs.git = {
    enable = true;
    userName = "Luta Vasile";
    userEmail = "elsile69@yahoo.com";
  };
}
