{ config, pkgs, ... }:
let
  c = config.myDefaults.colors;
in
{
  programs.kitty = {
    enable = true;
    font = {
      name = config.myDefaults.fonts.primary;
      size = config.myDefaults.fonts.sizes.small;
    };
    extraConfig = ''
      background ${c.background}
      foreground ${c.foreground}
      selection_background ${c.selection}
      selection_foreground ${c.foreground}
      cursor ${c.blue}
      cursor_text_color ${c.background}
      url_color ${c.blue}
      active_tab_background ${c.altBackground}
      active_tab_foreground ${c.foreground}
      inactive_tab_background ${c.background}
      inactive_tab_foreground ${c.darkGray}
      color0 ${c.selection}
      color1 ${c.red}
      color2 ${c.green}
      color3 ${c.yellow}
      color4 ${c.blue}
      color5 ${c.pink}
      color6 ${c.teal}
      color7 #b5bfe2
      color8 ${c.darkGray}
      color9 ${c.red}
      color10 ${c.green}
      color11 ${c.yellow}
      color12 ${c.blue}
      color13 ${c.pink}
      color14 ${c.teal}
      color15 #a5adce
      enable_audio_bell no
      background_opacity ${toString config.myDefaults.ui.opacity.terminal}
      open_url_with default
      mouse_map left click ungrabbed mouse_handle_click prompt
      mouse_map ctrl+left click ungrabbed mouse_handle_click link
    '';
  };
}
