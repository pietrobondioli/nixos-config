{ config, pkgs, lib, ... }:

{
  # Configure X11 windowing system
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };

  # Display manager configuration
  services.displayManager.ly = {
    enable = true;
  };

  # Default session for display manager
  services.displayManager.defaultSession = "niri";

  # Enable touchpad support
  services.libinput.enable = true;
}
