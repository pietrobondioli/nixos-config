{ lib, ... }:

{
  # Desktop-specific overrides (AMD + NVIDIA, 4K monitor)
  config.myDefaults.system.hostname = lib.mkForce "desktop";

  config.myDefaults.display = lib.mkForce {
    output = "HDMI-A-1";
    resolution = "3840x2160@60.000";
    scale = 1.60;
  };
}
