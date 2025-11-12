{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override { niriSupport = true; };
  };
}