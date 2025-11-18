{ config, pkgs, lib, ... }:

{
  programs.niri.enable = true;

  # Niri-specific packages
  environment.systemPackages = with pkgs; [
    xwayland-satellite # Xwayland outside Wayland (rootful Xwayland for niri)
  ];
}
