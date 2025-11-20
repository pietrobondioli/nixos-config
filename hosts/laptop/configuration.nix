# Laptop configuration
# Samsung Book Intel i5 - Development focused

{ config, lib, pkgs, ... }:

{
  imports = [
    # Hardware scan (generate this on the laptop with nixos-generate-config)
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
    ../../modules/system/virtualization.nix # Keep for dev work (Docker, VMs)
    ../../modules/system/filesystems.nix
    ../../modules/system/nixpkgs.nix
    ../../modules/system/xdg.nix

    # Hardware modules - LAPTOP SPECIFIC
    # NOTE: NO NVIDIA module - using Intel integrated graphics
    ../../modules/system/hardware/bluetooth.nix

    # Security modules
    ../../modules/system/security/yubikey.nix
    ../../modules/system/security/polkit.nix

    # Programs
    # NOTE: NO Steam - dev focused laptop
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
    ../../modules/system/services/upower.nix # Important for battery management
    ../../modules/system/services/rtkit.nix
  ];

  # Laptop-specific power optimization
  # Enable TLP for better battery life
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  system.stateVersion = "25.05";
}
