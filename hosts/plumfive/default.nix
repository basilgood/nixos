{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/damson
  ];

  networking.hostName = "plumfive";
  programs.sway = {
    status = with pkgs; "${i3status-rust}/bin/i3status-rs ${
        writeText "status.toml" ''
          [theme]
          name = "slick"
          [theme.overrides]
          idle_bg = "#2E3440"
          idle_fg = "#839496"
          separator = ""
          [icons]
          name = "awesome"
          [[block]]
          block = "memory"
          display_type = "memory"
          format_mem = "{Mug}G"
          format_swap = "{SUp}%"
          [[block]]
          block = "cpu"
          format = "{utilization}% {frequency}"
          [[block]]
          block = "temperature"
          collapsed = false
          interval = 1
          format = "{max}°"
          chip= "k10temp-*"
          idle= 70
          info= 75
          warning= 80
          [[block]]
          block = "temperature"
          collapsed = false
          interval = 1
          format = "{max}°"
          chip= "amdgpu-*"
          [[block]]
          block = "sound"
          [[block]]
          block = "time"
          interval = 60
          format = "%a %d/%m %R"
        ''
      }";
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
