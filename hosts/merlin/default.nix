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
          date_formatted=" "$(date "+%a %d/%m %R")
          battery=$(ls /sys/class/power_supply | grep BAT)
          bat_path=$(/sys/class/power_supply/$battery)
          status=$bat_path/status
          [ "$1" = `cat $status` ] || [ "$1" = "" ] || return 0
          if [ -f "$bat_path/energy_full" ]; then
            naming="energy"
          elif [ -f "$bat_path/charge_full" ]; then
            naming="charge"
          elif [ -f "$bat_path/capacity" ]; then
            cat "$bat_path/capacity"
            return 0
          fi
          bat_percent=$(( 100 * $(cat $bat_path/''${naming}_now) / $(cat $bat_path/''${naming}_full) ))
          bat_total=$(( ''${bat_total-0} + $bat_percent ))
          if [ -d "/sys/class/power_supply/BAT0" ]
          then
            [ $battery_status = "discharging" ] && battery_pluggedin=" " || battery_pluggedin=" "
          fi
          audio_volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
          audio_is_muted=$(${pkgs.pamixer}/bin/pamixer --get-mute)
          [ $audio_is_muted = "true" ] && audio="婢 mute" || audio=" "$audio_volume%
          mem=" "$(free -m | ${pkgs.gawk}/bin/awk 'NR==2{printf "%.1fG", $3/1024; exit}')
          cpu="  "$(${pkgs.gawk}/bin/awk '{ print $1; exit }' /proc/loadavg)
          cpuf=$((`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq` / 1000))
          cput=" "$(${pkgs.lm_sensors}/bin/sensors k10temp-pci-00c3 | ${pkgs.gawk}/bin/awk '/Tdie/ {print $2}' | cut -c 2-5)
          gput=$(${pkgs.lm_sensors}/bin/sensors amdgpu-pci-1000 | ${pkgs.gawk}/bin/awk '/edge/ {print $2}' | cut -c 2-5)
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
