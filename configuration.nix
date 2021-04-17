{ config, pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  time.timeZone = "Europe/Bucharest";

  networking.hostName = "hermes";
  networking.networkmanager = {
    enable = true;
    dns = "dnsmasq";
  };
  networking.extraHosts = ''
    127.0.0.1 local.cosmoz.com
  '';

  services.upower.enable = true;

  virtualisation.lxc.enable = true;
  virtualisation.lxd.enable = true;
  programs.dconf.enable = true;
  programs.adb.enable = true;
  security.pam.services.swaylock = { };
  services.dbus.packages = [ pkgs.gcr ];
  services.openvpn.servers = { plumelo = { config = "config /home/vasy/.config/plumelo.ovpn"; autoStart = false; updateResolvConf = true; }; };

  fonts.fontconfig.defaultFonts = {
    monospace = [ "DejaVuSansMono Nerd Font" ];
  };
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "DejaVuSansMono" ]; })
    noto-fonts-cjk
    noto-fonts-emoji
    cascadia-code
  ];

  hardware.sane.enable = true;
  hardware.bluetooth.enable = true;

  users.defaultUserShell = pkgs.bash;
  users.users.vasy = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "disk"
      "audio"
      "video"
      "networkmanager"
      "systemd-journal"
      "scanner"
      "lp"
      "adbusers"
    ];
  };
}
