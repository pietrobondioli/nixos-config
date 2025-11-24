{ lib, ... }:

{
  # Desktop-specific overrides (AMD + NVIDIA, 4K monitor)
  config.myDefaults.system.hostname = lib.mkForce "desktop";

  config.myDefaults.display = lib.mkForce {
    output = "HDMI-A-1";
    resolution = "3840x2160@60.000";
    scale = 1.60;
  };

  # Desktop-specific drive mount points
  config.myDefaults.theme.gtkBookmarks = [
    "file:///mnt/btrfs-drive btrfs-drive"
    "file:///mnt/exfat-drive exfat-drive"
    "file:///mnt/ext4-drive ext4-drive"
    "file:///mnt/nvme-extra nvme-extra"
  ];

  # Add additional directories for desktop if needed
  # config.myDefaults.user.ensureDirectories = lib.mkForce [
  #   "Downloads"
  #   "personal"
  #   "work"
  #   "projects"  # Add custom directories here
  #   "media"
  # ];
}
