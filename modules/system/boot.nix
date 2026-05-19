{ config, pkgs, lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Keep more generations in boot menu for fallback
  boot.loader.systemd-boot.configurationLimit = 15;

  # Pin to kernel 6.18 - 6.12 causes black screen on NVIDIA,
  # 6.18.31+ breaks MT7921 Bluetooth (Failed to send wmt func ctrl -22)
  # If BT breaks again after a flake lock update, revert flake.lock or
  # pin nixpkgs to a revision with a working 6.18.x kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_18;
}
