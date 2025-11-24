{ config, pkgs, ... }:
let
  userHome = config.myDefaults.user.home;
  standardBookmarks = [
    "file://${userHome}/personal personal"
    "file://${userHome}/work work"
    "file://${userHome}/Downloads Downloads"
    "file://${userHome}/Documents Documents"
    "file://${userHome}/Pictures Pictures"
    "file://${userHome}/Videos Videos"
    "file://${userHome}/Music Music"
    "file://${userHome}/Templates Templates"
  ];
  hostBookmarks = config.myDefaults.theme.gtkBookmarks;
in
{
  gtk = {
    enable = true;
    gtk3.bookmarks = standardBookmarks ++ hostBookmarks;

    theme = { name = config.myDefaults.theme.gtk; package = pkgs.gnome-themes-extra; };
    iconTheme = { name = config.myDefaults.theme.icons; package = pkgs.adwaita-icon-theme; };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
