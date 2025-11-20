{ config, pkgs, ... }: {
  gtk = {
    enable = true;
    gtk3.bookmarks = [
      "file://${config.myDefaults.user.home}/personal personal"
      "file://${config.myDefaults.user.home}/work/syniti syniti"
      ""
      "file://${config.myDefaults.user.home}/Downloads downloads"
      "file://${config.myDefaults.user.home}/Documents documents"
      "file://${config.myDefaults.user.home}/Pictures pictures"
      "file://${config.myDefaults.user.home}/Videos videos"
      "file://${config.myDefaults.user.home}/Music music"
      "file://${config.myDefaults.user.home}/Templates templates"
      ""
      "file:///mnt/btrfs-drive btrfs-drive"
      "file:///mnt/exfat-drive exfat-drive"
      "file:///mnt/ext4-drive ext4-drive"
      "file:///mnt/nvme-extra nvme-extra"
    ];

    theme = { name = config.myDefaults.theme.gtk; package = pkgs.gnome-themes-extra; };
    iconTheme = { name = config.myDefaults.theme.icons; package = pkgs.adwaita-icon-theme; };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
