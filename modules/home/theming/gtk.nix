{ config, pkgs, ... }: {
  gtk = {
    enable = true;
    gtk3.bookmarks = [
      "file:///mnt/btrfs-drive Btrfs Drive"
      "file:///mnt/exfat-drive ExFAT Drive"
      "file:///mnt/ext4-drive Ext4 Drive"
      "file:///mnt/nvme-extra NVMe Extra"
      "file://${config.myDefaults.user.home}/work/syniti Syniti"
      "file://${config.myDefaults.user.home}/personal/sandbox Sandbox"
      "file://${config.myDefaults.user.home}/Downloads Downloads"
      "file://${config.myDefaults.user.home}/Documents Documents"
      "file://${config.myDefaults.user.home}/Pictures Pictures"
      "file://${config.myDefaults.user.home}/Videos Videos"
      "file://${config.myDefaults.user.home}/Music Music"
      "file://${config.myDefaults.user.home}/Templates Templates"
    ];
    theme = { name = config.myDefaults.theme.gtk; package = pkgs.gnome-themes-extra; };
    iconTheme = { name = config.myDefaults.theme.icons; package = pkgs.adwaita-icon-theme; };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
