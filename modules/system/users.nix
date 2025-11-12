{ config, pkgs, lib, ... }:

{
  # Define user account
  users.users.pietro = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "input" "video" "plugdev" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };
}
