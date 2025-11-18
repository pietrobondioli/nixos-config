{ config, pkgs, ... }: {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = config.myDefaults.theme.cursor.name;
    size = config.myDefaults.theme.cursor.size;
    gtk.enable = true;
    x11.enable = true;
  };
}
