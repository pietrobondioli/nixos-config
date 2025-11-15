{ config, pkgs, lib, ... }:

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  xdg.portal.wlr.enable = true;

  # Explicitly configure which portals to use and in what order
  xdg.portal.config = {
    niri = {
      default = [ "wlr" "gtk" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
    };
  };

  # Prevent auto-detection of other portals
  xdg.portal.xdgOpenUsePortal = true;

  environment.sessionVariables = {
    GSK_RENDERER = "gl";
    GDK_BACKEND = "wayland";
  };
}
