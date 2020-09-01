{ config, pkgs, ... }:
let
  bar = pkgs.writeShellScriptBin "script.sh" ''
    date_formatted=$(date "+%a %d/%m %R")
    battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
    battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')
    audio_volume=$(pamixer --get-volume)
    audio_is_muted=$(pamixer --get-mute)
    if [ $audio_is_muted = "true" ]
    then
        audio="婢 mute"
    else
        audio=" "$audio_volume%
    fi
    mem=$(free -m | awk 'NR==2{printf "%.1fG", $3/1024 }')
    echo  $mem $audio $battery_charge $battery_status $date_formatted
  '';
  # block =
  #   if conf == "No support for device type: power_supply" then ""
  #   else ''
  #     [[block]]
  #     block = "battery"
  #     driver = "upower"
  #     format = "{percentage}% {time}"
  #     device = "DisplayDevice"
  #   '';
in
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/damson
  ];

  networking.hostName = "merlin";
  programs.sway = {
    status = ''
      while ${bar}/bin/script.sh; do sleep 1; done
      '';
    # programs.sway = {
    #   status = with pkgs; "${i3status-rust}/bin/i3status-rs ${
    #       writeText "status.toml" ''
    #         [theme]
    #         name = "slick"
    #         [theme.overrides]
    #         idle_bg = "#2E3440"
    #         idle_fg = "#839496"
    #         separator = ""
    #         [icons]
    #         name = "awesome"
    #         [[block]]
    #         block = "memory"
    #         display_type = "memory"
    #         format_mem = "{Mug}G"
    #         format_swap = "{SUp}%"
    #         [[block]]
    #         block = "cpu"
    #         format = "{utilization}% {frequency}"
    #         [[block]]
    #         block = "temperature"
    #         collapsed = false
    #         interval = 1
    #         format = "{max}°"
    #         chip= "k10temp-*"
    #         idle= 70
    #         info= 75
    #         warning= 80
    #         [[block]]
    #         block = "temperature"
    #         collapsed = false
    #         interval = 1
    #         format = "{max}°"
    #         chip= "amdgpu-*"
    #         ${block}
    #         [[block]]
    #         block = "sound"
    #         [[block]]
    #         block = "time"
    #         interval = 60
    #         format = "%a %d/%m %R"
    #       ''
    #     }";
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
