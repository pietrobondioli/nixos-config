{ lib, ... }:

{
  # Laptop-specific overrides (Intel iGPU, built-in display)
  config.myDefaults.system.hostname = lib.mkForce "laptop";

  # Run 'niri msg outputs' to find the correct output name and resolution
  config.myDefaults.display = lib.mkForce {
    output = "DP-1";
    resolution = "1920x1080@60.000";
    scale = 1.0;
  };

  # Brazilian keyboard layout with cedilla
  config.myDefaults.system.keyboardLayout = lib.mkForce "br";
  config.myDefaults.system.keyboardVariant = lib.mkForce "abnt2";
}
