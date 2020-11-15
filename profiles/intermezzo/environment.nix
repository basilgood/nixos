{ config, pkgs, ... }:
{
  environment = {
    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-icon-theme-name=Paper
        gtk-theme-name=Nordic-bluish-accent
      '';
      mode = "444";
    };
    variables = rec {
      VISUAL = "vim";
      EDITOR = VISUAL;
      BATH_THEME = "TwoDark";
      PATH = [ "~/.local/bin" ];
    };
  };
}
