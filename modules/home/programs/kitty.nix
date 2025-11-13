{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font = { name = "JetBrainsMono Nerd Font"; size = 13; };
    extraConfig = ''
      background #303446
      foreground #c6d0f5
      selection_background #414559
      selection_foreground #c6d0f5
      cursor #8caaee
      cursor_text_color #303446
      url_color #8caaee
      active_tab_background #292c3c
      active_tab_foreground #c6d0f5
      inactive_tab_background #303446
      inactive_tab_foreground #51576d
      color0 #414559
      color1 #e78284
      color2 #a6d189
      color3 #e5c890
      color4 #8caaee
      color5 #f4b8e4
      color6 #99d1db
      color7 #b5bfe2
      color8 #51576d
      color9 #e78284
      color10 #a6d189
      color11 #e5c890
      color12 #8caaee
      color13 #f4b8e4
      color14 #99d1db
      color15 #a5adce
      enable_audio_bell no
      background_opacity 0.95
    '';
  };
}
