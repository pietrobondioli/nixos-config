# PLACEHOLDER - Replace this file on the laptop
#
# On the Samsung Book laptop, run:
#   sudo nixos-generate-config --show-hardware-config > /home/pietro/personal/nixos-config/hosts/laptop/hardware-configuration.nix
#
# This will detect:
# - Intel CPU (and enable kvm-intel)
# - Proper disk/partition UUIDs
# - Available kernel modules
# - Intel graphics drivers

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # PLACEHOLDER - These will be replaced by nixos-generate-config
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ]; # Intel CPU
  boot.extraModulePackages = [ ];

  # PLACEHOLDER - Replace with actual partition UUIDs from the laptop
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-ACTUAL-UUID";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-ACTUAL-UUID";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
