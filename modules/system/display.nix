{ config, pkgs, lib, ... }:

{
  # Icon themes
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    papirus-icon-theme
  ];

  # Configure X11 windowing system
  services.xserver = {
    enable = true;
    xkb = {
      layout = config.myDefaults.system.keyboardLayout;
      variant = config.myDefaults.system.keyboardVariant;
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
