{ config, pkgs, lib, ... }:

{
  services.gnome.gnome-keyring.enable = true;

  # Enable PAM integration to auto-unlock keyring on login
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
    ly.enableGnomeKeyring = true;
    swaylock.enableGnomeKeyring = true;
    zsh.enableGnomeKeyring = true;
  };

  # Set environment variables for keyring socket communication
  environment.sessionVariables = {
    GNOME_KEYRING_CONTROL = "$XDG_RUNTIME_DIR/keyring";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
  };
}
