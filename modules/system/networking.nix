{ config, pkgs, lib, ... }:

{
  # Network utilities and VPN packages
  environment.systemPackages = with pkgs; [
    bind.dnsutils # provides dig, nslookup, etc.
    iproute2 # provides ip command
    net-tools # provides ifconfig, netstat, etc.
    wireguard-tools # WireGuard VPN tools
    protonvpn-gui # ProtonVPN GUI
  ];

  networking.hostName = config.myDefaults.system.hostname;
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # NetworkManager tray icon
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = config.myDefaults.system.timezone;

  # Firewall configuration
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = false;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
