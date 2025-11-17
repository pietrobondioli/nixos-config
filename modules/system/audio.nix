{ config, pkgs, lib, ... }:

{
  # Enable sound with pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    audio.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire = {
      "10-min-quantum" = {
        "context.properties" = {
          "default.clock.min-quantum" = 1024;
        };
      };
    };
  };

  programs.noisetorch.enable = true;

  # PAM services configuration for swaylock
  security.pam.services.swaylock = {};
}
