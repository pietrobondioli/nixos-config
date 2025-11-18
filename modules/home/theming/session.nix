{ config, ... }: {
  home.sessionVariables = {
    GTK_THEME = "${config.myDefaults.theme.gtk}:dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    NIXOS_OZONE_WL = "1";
    BROWSER = config.myDefaults.applications.browser.package;
  };
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
