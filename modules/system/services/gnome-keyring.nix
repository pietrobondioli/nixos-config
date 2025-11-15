{ config, pkgs, lib, ... }:

{
  # Enable GNOME Keyring service
  services.gnome.gnome-keyring.enable = true;

  # Enable PAM integration to auto-unlock keyring on login
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
    ly.enableGnomeKeyring = true;
  };
}
