{ config, pkgs, lib, ... }:

{
  # NetworkManager system tray applet
  services.network-manager-applet.enable = true;
}
