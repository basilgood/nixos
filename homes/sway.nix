{ pkgs, config, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  wayland.windowManager.sway.config = {
    menu = "${pkgs.j4-dmenu-desktop}/bin/j4-dmenu-desktop --term=$terminal";
    modifier = "Mod4";
    terminal = "alacritty";
    input."type:touchpad" = {
      dwt = "disabled";
      tap = "enabled";
      natural_scroll = "enabled";
      middle_emulation = "enabled";
    };
    gaps = {
      inner = 3;
      smartBorders = "on";
      smartGaps = true;
    };
    window = {
      border = 2;
      titlebar = false;
      commands = [
        {
          criteria = { class = "^.*"; };
          command = "inhibit_idle fulscreen";
        }
        {
          criteria = { class = "Google-chrome"; };
          command = "floating enable, resize set width 1280px 800px";
        }
        {
          criteria = { app_id = "keepassxc"; };
          command = "floating enable, resize set width 1276px 814px";
        }
      ];
    };
    keybindings = lib.mkOptionDefault {
      XF86AudioRaiseVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
      XF86AudioLowerVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
      XF86AudioMute = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
      XF86MonBrightnessDown = "exec brightnessctl set 10%-";
      XF86MonBrightnessUp = "exec brightnessctl set +10%";
      "Print" = "exec grimshot copy area";
      "Shift+Print" = "exec grimshot save area";
      "Mod4+Control+l" = "exec loginctl lock-session";
    };
    fonts = [ "JetBrainsMono Nerd Font" ];
    bars = [{ command = "waybar"; }];
    startup = [
      { command = "mako"; }
      {
        command = ''
          exec swayidle -w \
          timeout 300 'swaylock -f -c 000000' \
          timeout 1500 'swaymsg "output * dpms off"' \
             resume 'swaymsg "output * dpms on"' \
          before-sleep 'swaylock -f -c 000000'
        '';
      }
    ];
  };

  programs = {
    waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "bottom";
          height = 18;
          modules-left = [ "sway/workspaces" "sway/mode" ];
          modules-center = [ ];
          modules-right = [
            "idle_inhibitor"
            "network"
            "battery"
            "cpu"
            "memory"
            "temperature"
            "pulseaudio"
            "clock"
            "tray"
          ];
          modules = {
            idle_inhibitor = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
              on-click = "exec swaymsg inhibit_idle open";
            };
            battery = {
              bat = "BAT1";
              format = " {icon} {capacity}%";
              format-icons = [ " " " " " " " " " " ];
            };
            clock = {
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format = "{:%A %d %B, %H:%M}";
            };
            cpu = {
              format = " {usage}%";
              interval = "1";
            };
            memory = { format = " {used:0.1f} GB"; };
            network = {
              format = "{icon}";
              format-alt = "{ipaddr}/{cidr}";
              format-alt-click = "click-right";
              format-icons = {
                wifi = [ "" ];
                ethernet = [ "" ];
                disconnected = [ "" ];
              };
              tooltip-format = "{ifname}";
              tooltip-format-wifi = "{essid} ({signalStrength}%)";
              tooltip-format-ethernet = "{ifname}";
              tooltip-format-disconnected = "Disconnected";
              on-click = "alacritty -e nmtui";
            };
            temperature = {
              hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
              critical-threshold = 80;
              format = " {temperatureC}°C";
            };
            pulseaudio = {
              format = "{icon} {volume}%";
              format-bluetooth = "{icon} [{desc}] {volume}%";
              format-muted = " {volume}%";
              format-icons = {
                default = [ "" "" ];
                headphones = "";
              };
              on-click = "alacritty -e pulsemixer";
            };
            tray = {
              icon-size = 21;
              spacing = 10;
            };
          };
        }
      ];
    };
  };

  home.packages = with pkgs; [
    swaylock
    swayidle
    wl-clipboard
    brightnessctl
    sway-contrib.grimshot
    lm_sensors
    pavucontrol
    pulsemixer
    libappindicator
  ];

  programs.mako = {
    enable = true;
    layer = "overlay";
    font = "monospace 10";
    textColor = "#b3b1ad";
    backgroundColor = "#000000";
    borderColor = "#1f1a10";
    borderSize = 2;
    borderRadius = 5;
    defaultTimeout = 15000;
    sort = "+time";
  };
}
