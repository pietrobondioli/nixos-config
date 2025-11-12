{ config, pkgs, lib, ... }:

{
  fileSystems = {
    # Btrfs drive (sda1)
    "/mnt/btrfs-drive" = {
      device = "/dev/disk/by-uuid/49317738-381d-4e44-bfd6-8d0f3ce17b56";
      fsType = "btrfs";
      options = [ "defaults" "nofail" ];
    };

    # exFAT drive (sdb1) - good for Windows/Mac compatibility
    "/mnt/exfat-drive" = {
      device = "/dev/disk/by-uuid/7FEA-F9DB";
      fsType = "exfat";
      options = [ "defaults" "uid=1000" "gid=100" "umask=022" "nofail" ];
    };

    # ext4 drive (sdc1)
    "/mnt/ext4-drive" = {
      device = "/dev/disk/by-uuid/32bbee13-3044-4584-a387-cd2bd29c65a9";
      fsType = "ext4";
      options = [ "defaults" "nofail" ];
    };

    # Second NVMe drive (nvme1n1p2) - ext4 partition
    "/mnt/nvme-extra" = {
      device = "/dev/disk/by-uuid/f67a281a-1938-42d2-acfa-364981de89b1";
      fsType = "ext4";
      options = [ "defaults" "nofail" ];
    };
  };
}
