{ ... }:

{
  # Desktop-specific overrides (AMD + NVIDIA, 4K monitor)
  config.myDefaults.system.hostname = "desktop";

  config.myDefaults.display = {
    output = "HDMI-A-1";
    resolution = "3840x2160@60.000";
    scale = 1.60;
  };
}
