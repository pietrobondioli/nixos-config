{ ... }: {
  xdg.configFile."niri" = { source = ../../../dotfiles/niri; recursive = true; };
  xdg.configFile."zellij" = { source = ../../../dotfiles/zellij; recursive = true; };
  xdg.configFile."wallpapers" = { source = ../../../dotfiles/wallpapers; recursive = true; };
  xdg.configFile."waybar" = { source = ../../../dotfiles/waybar; recursive = true; };
  xdg.configFile."satty" = { source = ../../../dotfiles/satty; recursive = true; };
  home.file."scripts" = { source = ../../../dotfiles/scripts; recursive = true; };
}
