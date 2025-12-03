# Desktop configuration
# Gaming desktop with AMD CPU + NVIDIA GPU

{ config, lib, pkgs, ... }:

{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix

    # Shared defaults (must come before host-specific overrides)
    ../../modules/shared/defaults.nix

    # Host-specific defaults (overrides shared defaults)
    ./defaults.nix

    # System modules (all shared)
    ../../modules/system/boot.nix
    ../../modules/system/networking.nix
    ../../modules/system/display.nix
    ../../modules/system/audio.nix
    ../../modules/system/users.nix
    ../../modules/system/core-packages.nix
    ../../modules/system/virtualization.nix
    ../../modules/system/filesystems.nix
    ../../modules/system/nixpkgs.nix
    ../../modules/system/xdg.nix

    # Hardware modules - DESKTOP SPECIFIC
    ../../modules/system/hardware/nvidia.nix # Has NVIDIA GPU
    ../../modules/system/hardware/bluetooth.nix

    # Security modules
    ../../modules/system/security/yubikey.nix
    ../../modules/system/security/polkit.nix

    # Programs
    ../../modules/system/programs/steam.nix # Gaming on desktop
    ../../modules/system/programs/firefox.nix
    ../../modules/system/programs/niri.nix
    ../../modules/system/programs/zsh.nix
    ../../modules/system/programs/gnupg.nix
    ../../modules/system/programs/1password.nix
    ../../modules/system/programs/thunar.nix
    ../../modules/system/programs/nix-ld.nix
    ../../modules/system/programs/seahorse.nix

    # Services
    ../../modules/system/services/openssh.nix
    ../../modules/system/services/bluetooth.nix
    ../../modules/system/services/gnome-keyring.nix
    ../../modules/system/services/gvfs.nix
    ../../modules/system/services/ydotool.nix
    ../../modules/system/services/upower.nix
    ../../modules/system/services/rtkit.nix
  ];

  system.stateVersion = "25.11";
}
