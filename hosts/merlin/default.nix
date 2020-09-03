{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/damson
  ];

  networking.hostName = "merlin";

  programs.sway = {
    status =
      let
        bar = pkgs.writeShellScriptBin "script.sh" ''
          date_formatted=$(date "+%a %d/%m %R")
          battery_status=$(${pkgs.upower}/bin/upower --show-info $(${pkgs.upower}/bin/upower --enumerate | grep 'BAT') | grep -E "state" | ${pkgs.gawk}/bin/awk '{print $2}')
          battery_charge=$(${pkgs.upower}/bin/upower --show-info $(${pkgs.upower}/bin/upower --enumerate | grep 'BAT') | grep -E "percentage" | ${pkgs.gawk}/bin/awk '{print $2}')
          battery_time=$(${pkgs.upower}/bin/upower --show-info $(${pkgs.upower}/bin/upower --enumerate | grep 'BAT') | grep -E "time" | cut -d ':' -f2|xargs)
          if [ -d "/sys/class/power_supply/BAT0" ]
          then
            [ $battery_status = "discharging" ] && battery_pluggedin=" " || battery_pluggedin=" "
          fi
          audio_volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
          audio_is_muted=$(${pkgs.pamixer}/bin/pamixer --get-mute)
          if [ $audio_is_muted = "true" ]
          then
            audio="婢 mute"
          else
            audio=" "$audio_volume%
          fi
          mem=$(free -m | ${pkgs.gawk}/bin/awk 'NR==2{printf "%.1fG", $3/1024; exit}')
          cpu=$(${pkgs.gawk}/bin/awk '{ print $1; exit }' /proc/loadavg)
          cpuf=$((`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq` / 1000))
          cput=$(${pkgs.lm_sensors}/bin/sensors k10temp-pci-00c3 | ${pkgs.gawk}/bin/awk '/Tdie/ {print $2}' | cut -c 2-5)
          gput=$(${pkgs.lm_sensors}/bin/sensors amdgpu-pci-1000 | ${pkgs.gawk}/bin/awk '/edge/ {print $2}' | cut -c 2-5)
          echo  $mem   $cpu $cpuf  $cput  $gput $audio $battery_pluggedin $battery_time $battery_charge  $date_formatted
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
