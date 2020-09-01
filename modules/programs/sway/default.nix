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
      ]);
      extraSessionCommands = ''
        export XKB_DEFAULT_LAYOUT=us
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

      set $brightness ${brightnessctl}/bin/brightnessctl
      set $grim ${grim}/bin/grim
      set $mogrify ${imagemagick}/bin/mogrify
      set $slurp ${slurp}/bin/slurp
      set $mako ${mako}/bin/mako
      set $idle ${swayidle}/bin/swayidle
      set $lock ${swaylock}/bin/swaylock -c 550000
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

      bindsym --release $mod+Control+l exec loginctl lock-session
      exec $idle -w \
        timeout 300 'swaymsg "output * dpms off"' \
          resume 'swaymsg "output * dpms on"' \
        timeout 600 $lock \
        timeout 900 $suspend \
        before-sleep $lock

      gaps inner 2
      gaps outer 0
      smart_gaps on
      hide_edge_borders smart
      default_border pixel 1
      default_floating_border pixel 1

      font pango: monospace 9

      # Status Bar:
      # colors
      set $bgcolor 161821
      set $fgcolor 2e617d
      set $txtcolor DFEFE2
      set $urgent EF6155

      bar bar-0 {
        position bottom
        ${ if (cfg.status != null) then "status_command ${cfg.status}" else "" }
        status_padding 0
        font monospace 9
        mode dock
        modifier none
        separator_symbol “⁞”
        colors {
          statusline #$txtcolor
          background #$bgcolor
          focused_workspace #2b7ab2 #2b7ab2 #fbffff
          active_workspace #6d7782 #6d7782 #fbffff
          inactive_workspace #161821 #161821 #DFEFE2
          urgent_workspace #ae5865 #ae5865 #fbffff
        }
        icon_theme Paper
      }

      exec --no-startup-id $mako --default-timeout=10000 \
        --font='sansSerif 9' \
        --background-color=#$bgcolor \
        --border-size=0 \
        --border-color=#$txtcolor \
        --max-icon-size=20

      set $gnome-schema org.gnome.desktop.interface
      exec_always {
        gsettings set $gnome-schema gtk-theme 'Nordic-bluish-accent'
        gsettings set $gnome-schema icon-theme 'Paper'
      }

      mode passthrough {
        bindsym $mod+Pause mode default
      }
      bindsym $mod+Pause mode passthrough

      ${cfg.extraConfig}
    '';
  };
}
