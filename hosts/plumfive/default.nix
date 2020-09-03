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
          batcapacity=$(cat /sys/class/power_supply/BAT1/capacity )%
          battery=$(cat /sys/class/power_supply/BAT1/status | head -c 1 | awk '''{print tolower($0)}''') $batcapacity
          [ ! -z $battery ] && ([ $batcapacity -lt 10 ] && \\e[31m"  "$battery || \\e[39m"  "$battery)
          audio_volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
          audio_is_muted=$(${pkgs.pamixer}/bin/pamixer --get-mute)
          [ $audio_is_muted = "true" ] && audio="婢 mute" || audio=" "$audio_volume%
          mem=" "$(free -m | ${pkgs.gawk}/bin/awk 'NR==2{printf "%.1fG", $3/1024; exit}')
          cpu="  "$(${pkgs.gawk}/bin/awk '{ print $1; exit }' /proc/loadavg)
          cpuf=$((`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq` / 1000))
          cput=" "$(${pkgs.lm_sensors}/bin/sensors k10temp-pci-* | ${pkgs.gawk}/bin/awk '/Tdie/ {print $2}' | cut -c 2-5)
          gput=$(${pkgs.lm_sensors}/bin/sensors amdgpu-pci-* | ${pkgs.gawk}/bin/awk '/edge/ {print $2}' | cut -c 2-5)
          echo $mem $cpu $cpuf $cput $gput $audio $battery_pluggedin $battery_time $battery_charge $date_formatted
        '';
      in
      ''
        while ${bar}/bin/script.sh; do sleep 1; done
      '';

    extraConfig = ''
      output * bg ${./wall.jpg} fill
        for_window {
          [class="^.*"] inhibit_idle fullscreen
          [app_id="^.*"] inhibit_idle fullscreen
          [class="^TelegramDesktop$"] floating enable
          [app_id="keepassxc"] floating enable
        }
    '';
  };
}
