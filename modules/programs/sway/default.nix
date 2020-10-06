{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.sway;
in
{

  options.programs.sway = {
    extraConfig = mkOption {
      type = types.lines;
      default = "";
    };

    terminal = mkOption {
      type = types.str;
      default = "${pkgs.alacritty}/bin/alacritty";
    };

    menu = mkOption {
      type = types.str;
      default = "${pkgs.bemenu}/bin/bemenu-run -i --prompt '▶' --tf '#3daee9' --hf '#3daee9' --sf '#3daee9' --scf '#3daee9'";
    };

    status = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
  };

  config = mkIf cfg.enable {

    programs.sway = {
      extraPackages = (with pkgs; [
        glib
        paper-icon-theme
        nordic
        xwayland
        android-udev-rules
        jmtpfs
        xdg_utils
        wl-clipboard
        lm_sensors
        imv
      ]);
      extraSessionCommands = ''
        export XKB_DEFAULT_LAYOUT=us
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=sway
        export DESKTOP_SESSION=sway
        export XDG_DATA_DIRS=${
          let schema = pkgs.gsettings-desktop-schemas;
            in "${schema}/share/gsettings-schemas/${schema.name}"
        }:$XDG_DATA_DIRS
      '';
    };

    users.defaultUser.extraGroups = [ "sway" ];
    networking.networkmanager.enable = true;

    services.upower.enable = true;
    services.udev.packages = with pkgs; [ brightnessctl android-udev-rules ];

    environment.etc."sway/config".text = with pkgs; ''
      include "${sway}/etc/sway/config"

      set $swaylock ${swaylock-effects}/bin/swaylock-effects
      set $brightness ${brightnessctl}/bin/brightnessctl
      set $grim ${grim}/bin/grim
      set $slurp ${slurp}/bin/slurp
      set $mako ${mako}/bin/mako
      set $idle ${swayidle}/bin/swayidle
      set $lock swaylock -f --screenshots --clock --fade-in 0.2 --effect-scale 0.4 --effect-vignette 0.2:0.5 --effect-blur 2x2 --grace 5
      set $menu ${cfg.menu}
      set $term ${cfg.terminal}

      # input
      input type:touchpad {
        tap enabled
        natural_scroll enabled
        middle_emulation enabled
      }

      # Basics:
      bindsym --no-warn $mod+Return exec $term
      bindsym --no-warn $mod+d exec $menu
      bindsym --no-warn $mod+Shift+e exit

      bindsym $mod+Tab workspace back_and_forth

      # Audio
      bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
      bindsym XF86MonBrightnessDown exec $brightness set 10%-
      bindsym XF86MonBrightnessUp exec $brightness set +10%

      bindsym Print exec $slurp | $grim -g - - | wl-copy

      bindsym --release $mod+ctrl+l exec '$lock'
      exec $idle -w \
        timeout 300 '$lock' \
        timeout 600 'systemctl suspend' \
        lock '$lock'

      gaps inner 2
      gaps outer 0
      smart_gaps on
      hide_edge_borders smart
      default_border pixel 1
      default_floating_border pixel 1

      font pango: monospace 9

      # Status Bar:
      bar bar-0 {
        position bottom
        ${ if (cfg.status != null) then "status_command ${cfg.status}" else "" }
        status_padding 0
        font monospace 9
        mode dock
        modifier none
        colors {
          statusline #888888
          background #202023
          focused_workspace  #247aa8 #2c2c2e #247aa8
          active_workspace   #2c2c2e #2c2c2e #247aa8
          inactive_workspace #2c2c2e #2c2c2e #8f8f8f
          urgent_workspace   #e89393 #2c2c2e #FCBF69
        }
        icon_theme Paper
      }

      exec --no-startup-id $mako \
      --max-visible=1 \
      --layer=overlay \
      --font=monospace 10 \
      --text-color=#b3b1ad \
      --background-color=#000000 \
      --border-color=#1f1a10 \
      --border-size=2 \
      --border-radius=5 \
      --default-timeout=10000

      set $gnome-schema org.gnome.desktop.interface
      exec_always {
        gsettings set $gnome-schema gtk-theme 'Nordic-bluish-accent'
        gsettings set $gnome-schema icon-theme 'Paper'
      }

      mode passthrough {
        bindsym $mod+Pause mode default
      }
      bindsym $mod+Pause mode passthrough
      for_window [class="^.*"] inhibit_idle fullscreen

      ${cfg.extraConfig}
    '';
  };
}
