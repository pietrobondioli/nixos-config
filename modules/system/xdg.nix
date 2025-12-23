{ config, pkgs, lib, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config.niri = {
      default = lib.mkForce [ "gnome;gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
    };
  };

  environment.systemPackages = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-gnome
  ];
  xdg.portal.xdgOpenUsePortal = true;

  # This is key - set environment for niri session
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri"; # ADD THIS
    QT_QPA_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    GSK_RENDERER = "gl";
    GDK_BACKEND = "wayland";
  };
}
