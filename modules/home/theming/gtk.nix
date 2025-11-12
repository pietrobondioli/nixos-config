{ pkgs, ... }: {
  gtk = {
    enable = true;
    gtk3.bookmarks = [
      "file:///mnt/btrfs-drive Btrfs Drive"
      "file:///mnt/exfat-drive ExFAT Drive"
      "file:///mnt/ext4-drive Ext4 Drive"
      "file:///mnt/nvme-extra NVMe Extra"
      "file:///home/pietro/work/syniti Syniti"
      "file:///home/pietro/personal/sandbox Sandbox"
      "file:///home/pietro/Downloads Downloads"
      "file:///home/pietro/Documents Documents"
      "file:///home/pietro/Pictures Pictures"
      "file:///home/pietro/Videos Videos"
      "file:///home/pietro/Music Music"
      "file:///home/pietro/Templates Templates"
    ];
    theme = { name = "Adwaita-dark"; package = pkgs.gnome-themes-extra; };
    iconTheme = { name = "Adwaita"; package = pkgs.adwaita-icon-theme; };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}