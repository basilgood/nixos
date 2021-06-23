{ config, options, lib, pkgs, ... }: {
  fonts.fontconfig.defaultFonts = {
    monospace = [ "DejaVuSansMono Nerd Font" ];
  };
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "DejaVuSansMono" ]; })
    noto-fonts-cjk
    noto-fonts-emoji
    cascadia-code
  ];
}
