{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/damson
  ];

  networking.hostName = "plumfive";
  programs.sway = {
    status =
      let
        bar = pkgs.writeShellScriptBin "script.sh" ''
          date_formatted=" "$(date "+%a %d/%m %R")
          audio_volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
          audio_is_muted=$(${pkgs.pamixer}/bin/pamixer --get-mute)
          [ $audio_is_muted = "true" ] && audio="婢 mute" || audio=" "$audio_volume%
          mem=" "$(free -m | ${pkgs.gawk}/bin/awk 'NR==2{printf "%.1fG", $3/1024; exit}')
          cpu="  "$(${pkgs.gawk}/bin/awk '{ print $1; exit }' /proc/loadavg)
          cpuf=$((`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq` / 1000))
          cput=" "$(${pkgs.lm_sensors}/bin/sensors k10temp-pci-* | ${pkgs.gawk}/bin/awk '/Tdie/ {print $2}' | cut -c 2-5)
          gput=$(${pkgs.lm_sensors}/bin/sensors amdgpu-pci-* | ${pkgs.gawk}/bin/awk '/edge/ {print $2}' | cut -c 2-5)
          echo $mem $cpu $cpuf $cput $gput $audio $date_formatted
        '';
      in
      ''
        while ${bar}/bin/script.sh; do sleep 1; done
      '';

    extraConfig = ''
      output * bg ${./wall.jpg} fill
      output "Goldstar Company Ltd W2486 0x00001FA6" mode 1920x1080@60Hz
      output "Samsung Electric Company SAMSUNG 0x00000F00" mode 4096x2160@60Hz scale_filter smart scale 1.5
      output "Goldstar Company Ltd LG ULTRAWIDE 0x0000BF93" mode 2560x1080@59.978001Hz scale_filter smart scale 1.1
      for_window {
        [class="^.*"] inhibit_idle fullscreen
        [app_id="^.*"] inhibit_idle fullscreen
        [class="^TelegramDesktop$"] floating enable
        [app_id="keepassxc"] floating enable
      }
    '';
  };
  programs.bash.shellAliases = {
    "n" = "nix develop github:basilgood/nvim-flake#";
  };
  programs.adb.enable = true;
  boot.kernelParams = [
    "resume_offset=2842624"
  ];
  boot.resumeDevice = "/dev/disk/by-label/root";
  swapDevices = [
    {
      device = "/swapfile";
      priority = 0;
      size = 2048;
    }
  ];
  virtualisation.wine.enable = true;
  services.lorri.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
}
