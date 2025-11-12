{ config, pkgs, lib, ... }:

{
  # Enable polkit for privilege management
  security.polkit.enable = true;
}
