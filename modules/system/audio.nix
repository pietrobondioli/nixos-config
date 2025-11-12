{ config, pkgs, lib, ... }:

{
  # Enable sound with pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # PAM services configuration for swaylock
  security.pam.services.swaylock = {};
}
