{ config, pkgs, lib, ... }:

{
  # Define user account
  users.users.${config.myDefaults.user.name} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "input" "video" "plugdev" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.${config.myDefaults.applications.shell};
  };
}
