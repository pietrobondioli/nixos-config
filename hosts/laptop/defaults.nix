{ ... }:

{
  # Laptop-specific overrides (Intel iGPU, built-in display)
  config.myDefaults.system.hostname = "lt";

  # Run 'niri msg outputs' to find the correct output name and resolution
  config.myDefaults.display = {
    output = "eDP-1";
    resolution = "1920x1080@60.000";
    scale = 1.0;
  };
}
