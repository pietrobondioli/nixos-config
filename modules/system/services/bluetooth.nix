{ config, pkgs, lib, ... }:

{
  # Enable Blueman service (Bluetooth manager)
  services.blueman.enable = true;
}
