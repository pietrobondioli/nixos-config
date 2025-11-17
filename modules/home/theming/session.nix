{ ... }: {
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    NIXOS_OZONE_WL = "1";
    BROWSER = "firefox";
  };
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
