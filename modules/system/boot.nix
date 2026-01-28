{ config, pkgs, lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Keep more generations in boot menu for fallback
  boot.loader.systemd-boot.configurationLimit = 15;

  # Pin to kernel 6.18 (latest stable) - 6.12.67 causes black screen on NVIDIA
  # Available: linuxPackages_6_1, linuxPackages_6_12, linuxPackages_6_13, etc.
  # Remove this line once the issue is fixed upstream
  boot.kernelPackages = pkgs.linuxPackages_6_18;
}
