{ config, pkgs, lib, ... }:

{
  programs.xfconf.enable = true;

  # Enable Thunar with plugins
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman # Automatic management of removable devices
      thunar-archive-plugin # Archive support
      thunar-media-tags-plugin # Media tags
    ];
  };

  # Install archive manager and additional archive tools for thunar-archive-plugin
  environment.systemPackages = with pkgs; [
    xfce.exo # XFCE helper for preferred applications (required for "Open Terminal Here")
    file-roller # Archive manager for Thunar plugin (works better on NixOS than xarchiver)
    gzip # For .gz files
    bzip2 # For .bz2 files
    p7zip # For .7z files
    xz # For .xz files
  ];
}
