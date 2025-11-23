{ config, pkgs, lib, ... }:

{
  # Enable graphics support with Intel drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      # Intel Media Driver (iHD) - for Gen 8+ (Broadwell and newer)
      # This is the modern driver for TigerLake (11th gen) and Iris Xe
      intel-media-driver

      # Legacy Intel VAAPI driver (i965) - kept for compatibility
      intel-vaapi-driver

      # VAAPI utilities for debugging (vainfo command)
      libva-utils

      # Additional Intel GPU tools
      intel-gpu-tools
    ];
  };

  # Load Intel graphics kernel module
  boot.kernelModules = [ "i915" ];

  # Set environment variable to prefer iHD driver (intel-media-driver)
  # over i965 (intel-vaapi-driver) for modern Intel GPUs
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
