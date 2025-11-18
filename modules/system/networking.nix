{ config, pkgs, lib, ... }:

{
  networking.hostName = "pc"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  
  # NetworkManager tray icon
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Firewall configuration
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = false;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
