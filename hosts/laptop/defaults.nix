{ ... }:

{
  # Laptop-specific overrides (Intel iGPU, built-in display)
  # NOTE: You'll need to adjust these values when you boot the laptop
  # Run 'niri msg outputs' to find the correct output name and resolution
  config.myDefaults.system.hostname = "laptop";

  config.myDefaults.display = {
    output = "eDP-1"; # Typical for laptop internal displays
    resolution = "1920x1080@60.000"; # Adjust based on actual laptop screen
    scale = 1.0; # Adjust based on your preference
  };
}
