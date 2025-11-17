{ config, pkgs, lib, ... }:

{
  # Enable Bluetooth hardware
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
