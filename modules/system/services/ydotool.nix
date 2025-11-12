{ config, pkgs, lib, ... }:

{
  systemd.services.ydotool = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };
}
