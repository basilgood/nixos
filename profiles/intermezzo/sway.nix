{ config, pkgs, ... }:
{
  programs = {
    sway = {
      enable = true;
      extraSessionCommands = "(sleep 10; exec ${pkgs.yeshup}/bin/yeshup ${pkgs.batsignal}/bin/batsignal -b -i -w 10 -m 60 -W 'Battery low.') &";
      menu = "${pkgs.bemenu}/bin/bemenu-run -w -i --prefix '⇒' --prompt 'Run: ' --hb '#404654' --ff '#c698e3' --tf '#c698e3' --hf '#fcfcfc'";
      extraConfig = ''
        bindsym $mod+i exec swaymsg inhibit_idle open
        bindsym $mod+Shift+i exec swaymsg inhibit_idle none
        bindsym $mod+p exec $slurp | $grim -g - - | wl-copy
        bindswitch lid:on output eDP-1 disable
        bindswitch lid:off output eDP-1 enable
        output * bg #141417 solid_color
        output HDMI-A-1 mode 3840x2160@60Hz scale_filter smart scale 1.5
        # output HDMI-A-1 mode 2560x1080@60Hz scale_filter smart scale 1.1
        for_window [class="^.*"] inhibit_idle fullscreen
        bar bar-0 {
          colors {
            statusline #888888
            background #141417
            focused_workspace  #247aa8 #2c2c2e #247aa8
            active_workspace   #2c2c2e #2c2c2e #247aa8
            inactive_workspace #2c2c2e #2c2c2e #8f8f8f
            urgent_workspace   #e89393 #2c2c2e #FCBF69
            binding_mode       #e89393 #2c2c2e #FCBF69
          }
        }
      '';
      wrapperFeatures = {
        gtk = true;
        base = true;
      };
      status =
        let
          bar = pkgs.writeShellScriptBin "script.sh" ''
            date_formatted=" "$(date "+%a %F %H:%M")
            baticon=" "
            batstatus=$(cat /sys/class/power_supply/BAT1/status | cut -c1)
            batlevel=$(cat /sys/class/power_supply/BAT1/capacity)
            audio_volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
            audio_is_muted=$(${pkgs.pamixer}/bin/pamixer --get-mute)
            [ $audio_is_muted = "true" ] && audio="婢 mute" || audio=" "$audio_volume%
            mem=" "$(free -m | ${pkgs.gawk}/bin/awk 'NR==2{printf "%.1fG", $3/1024; exit}')
            cpu="  "$(${pkgs.gawk}/bin/awk '{ print $1; exit }' /proc/loadavg)
            cpuf=$((`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq` / 1000 | head -c2))
            cput=" "$(${pkgs.lm_sensors}/bin/sensors k10temp-pci-* | ${pkgs.gawk}/bin/awk '/Tdie/ {print $2}' | cut -c 2-5)
            echo $baticon $batstatus $batlevel% $mem $cpu $cpuf $cput $audio $date_formatted
          '';
        in
        ''
          while ${bar}/bin/script.sh; do sleep 1; done
        '';
    };
  };
}
