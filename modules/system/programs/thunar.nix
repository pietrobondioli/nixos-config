{ config, pkgs, lib, ... }:

{
  programs.xfconf.enable = true;

  # Enable Thunar with plugins
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman        # Automatic management of removable devices
      thunar-archive-plugin # Archive support
      thunar-media-tags-plugin # Media tags
    ];
  };
}
