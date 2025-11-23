{ config, pkgs, lib, ... }:

{
  # Enable PAM integration to auto-unlock keyring on login
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
    ly.enableGnomeKeyring = true;
    swaylock.enableGnomeKeyring = true;
    zsh.enableGnomeKeyring = true;
  };
}
