{ config, pkgs, lib, ... }:

{
  # System packages
  environment.systemPackages = with pkgs; [
    xwayland-satellite

    # Essential system tools
    git
    wget
    curl
    vim
    unzip
    eza
    fd

    # Build essentials (needed for system operations)
    gcc
    libinput

    # Themes
    adwaita-icon-theme
    papirus-icon-theme

    yubikey-manager # CLI tool for YubiKey management
    yubikey-personalization # For configuring YubiKey slots
    yubico-pam # For PAM authentication
    yubioath-flutter # Optional: GUI tool

    libsecret
    usbutils

    nix-output-monitor
    pstree
    jq

    pkgs.xdg-desktop-portal-gnome
    pciutils
    vulkan-tools
    psmisc

    pulseaudio
    wireguard-tools
    protonvpn-gui
  ];
}
