{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      dynamic_title = true;
      window = {
        padding = {
          x = 0;
          y = 0;
        };
        dynamic_padding = true;
        decorations = "none";
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "italic";
        };
        size = 10;
        offset.x= 0;
        offset.y= 0;
        glyph_offset.x=0;
        glyph_offset.y=0;
      };
      draw_bold_text_with_bright_colors = false;
      colors = {
        primary = {
          background = "0x1a1b26";
          foreground = "0xa9b1d6";
        };
        cursor = {
          text = "0x2E3440";
          cursor = "0xD8DEE9";
          style = "Block";
          unfocused_hollow = false;
          blinking = "Off";
        };
        normal = {
          black = "0x32344a";
          red = "0xf7768e";
          green = "0x9ece6a";
          yellow ="0xe0af68";
          blue = "0x7aa2f7";
          magenta = "0xad8ee6";
          cyan = "0x449dab";
          white = "0x787c99";
        };
        bright = {
          black = "0x444b6a";
          red = "0xff7a93";
          green = "0xb9f27c";
          yellow = "0xff9e64";
          blue = "0x7da6ff";
          magenta = "0xbb9af7";
          cyan = "0x0db9d7";
          white = "0xacb0d0";
        };
      };
    };
  };
}
