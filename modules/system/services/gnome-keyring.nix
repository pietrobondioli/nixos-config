{ config, pkgs, lib, ... }:

{
  # Enable GNOME Keyring service
  services.gnome.gnome-keyring.enable = true;
}
