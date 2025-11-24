{ config, pkgs, lib, ... }:

# ============================================================================
# RClone Google Drive Configuration Guide
# ============================================================================
#
# To configure Google Drive with rclone, follow these steps:
#
# 1. Run rclone configuration:
#    $ rclone config
#
# 2. Create a new remote:
#    - Choose 'n' for "New remote"
#    - Name it 'gdrive' (must match the name used in this config)
#    - Choose the number for "Google Drive"
#
# 3. Configure the remote:
#    - client_id: Press Enter (leave empty unless you have a custom API)
#    - client_secret: Press Enter (leave empty)
#    - scope: Choose '1' for "Full access all files"
#    - root_folder_id: Press Enter (leave empty)
#    - service_account_file: Press Enter (leave empty)
#    - Use auto config?: Choose 'y' (will open browser for authentication)
#
# 4. Authenticate:
#    - Browser window will open
#    - Sign in to Google and grant access
#    - Should see "Success!" in browser
#
# 5. Complete configuration:
#    - Configure as team drive?: Choose 'n' (unless using team drive)
#    - Confirm configuration
#    - Choose 'q' to quit
#
# 6. Test the configuration:
#    $ rclone ls gdrive:
#
# 7. Enable and start the service:
#    $ systemctl --user enable rclone-gdrive.service
#    $ systemctl --user start rclone-gdrive.service
#    $ systemctl --user status rclone-gdrive.service
#
# Configuration is saved to: ~/.config/rclone/rclone.conf
# Mount point: ~/gdrive
#
# ============================================================================

{
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
          --vfs-cache-max-age 100h \
          --vfs-cache-max-size 10G \
          --vfs-read-chunk-size 32M \
          --vfs-read-chunk-size-limit off \
          --vfs-read-ahead 128M \
          --buffer-size 64M \
          --poll-interval 10s \
          --dir-cache-time 5000h \
          --attr-timeout 5m \
          --vfs-fast-fingerprint \
          --drive-pacer-min-sleep 10ms \
          --drive-pacer-burst 200 \
          --drive-chunk-size 32M \
          --timeout 1h \
          --umask 022
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
