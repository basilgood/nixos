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
          family = "Cascadia Code PL";
          style = "regular";
        };
        bold = {
          family = "Cascadia Code PL";
          style = "bold";
        };
        italic = {
          family = "Cascadia Code PL";
          style = "italic";
        };
        size = 10.5;
        offset.x= 0;
        offset.y= 0;
        glyph_offset.x=0;
        glyph_offset.y=0;
      };
      draw_bold_text_with_bright_colors = false;
      colors = {
        primary = {
          background = "0x282828";
          foreground = "0xebdbb2";
        };
        normal = {
          black =   "0x282828";
          red =     "0xf0664a";
          green =   "0x98971a";
          yellow =  "0xd79921";
          blue =    "0x81afaf";
          magenta = "0xb16286";
          cyan =    "0x689d6a";
          white =   "0xa89984";
        };
        bright = {
          black =   "0x928374";
          red =     "0xfb4934";
          green =   "0xb8bb26";
          yellow =  "0xfabd2f";
          blue =    "0x83a598";
          magenta = "0xd3869b";
          cyan =    "0x8ec07c";
          white =   "0xebdbb2";
        };
      };
      background_opacity=0.0;
    };
  };
}
