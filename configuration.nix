# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Shared defaults
    ./modules/shared/defaults.nix

    # System modules
    ./modules/system/boot.nix
    ./modules/system/networking.nix
    ./modules/system/display.nix
    ./modules/system/audio.nix
    ./modules/system/users.nix
    ./modules/system/core-packages.nix
    ./modules/system/virtualization.nix
    ./modules/system/filesystems.nix
    ./modules/system/nixpkgs.nix
    ./modules/system/xdg.nix

    # Hardware modules
    ./modules/system/hardware/nvidia.nix
    ./modules/system/hardware/bluetooth.nix

    # Security modules
    ./modules/system/security/yubikey.nix
    ./modules/system/security/polkit.nix

    # Programs
    ./modules/system/programs/steam.nix
    ./modules/system/programs/firefox.nix
    ./modules/system/programs/niri.nix
    ./modules/system/programs/zsh.nix
    ./modules/system/programs/gnupg.nix
    ./modules/system/programs/1password.nix
    ./modules/system/programs/thunar.nix
    ./modules/system/programs/nix-ld.nix
    ./modules/system/programs/seahorse.nix

    # Services
    ./modules/system/services/openssh.nix
    ./modules/system/services/bluetooth.nix
    ./modules/system/services/gnome-keyring.nix
    ./modules/system/services/gvfs.nix
    ./modules/system/services/ydotool.nix
    ./modules/system/services/upower.nix
    ./modules/system/services/rtkit.nix
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
