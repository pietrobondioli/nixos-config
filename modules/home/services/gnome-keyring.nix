{ pkgs, ... }:

{
  # Enable the GNOME Keyring daemon for the user session.
  # This automatically starts the daemon and exports the necessary
  # environment variables for applications to use it.
  services.gnome-keyring.enable = true;
}
