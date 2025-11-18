{ config, pkgs, lib, ... }:

{
  # Install rclone package
  home.packages = [ pkgs.rclone ];

  # Create mount directory
  home.file.".local/share/gdrive/.keep".text = "";

  # Add Google Drive to GTK bookmarks (appears in Thunar sidebar)
  xdg.configFile."gtk-3.0/bookmarks".text = ''
    file://${config.home.homeDirectory}/gdrive Google Drive
  '';

  # Systemd service for mounting Google Drive
  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "RClone mount for Google Drive";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "notify";
      ExecStartPre = "/run/current-system/sw/bin/mkdir -p %h/gdrive";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount gdrive: %h/gdrive \
          --vfs-cache-mode full \
          --vfs-cache-max-age 24h \
          --vfs-read-chunk-size 32M \
          --vfs-read-chunk-size-limit 2G \
          --vfs-read-ahead 128M \
          --buffer-size 64M \
          --poll-interval 15s \
          --dir-cache-time 5m \
          --attr-timeout 1s \
          --vfs-fast-fingerprint \
          --no-modtime \
          --drive-chunk-size 32M \
          --timeout 1h \
          --umask 022 \
          --allow-other
      '';
      ExecStop = "/run/current-system/sw/bin/fusermount -u %h/gdrive";
      Restart = "on-failure";
      RestartSec = "30s";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
