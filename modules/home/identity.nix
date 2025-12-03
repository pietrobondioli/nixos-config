{ config, pkgs, ... }: {
  home.username = config.myDefaults.user.name;
  home.homeDirectory = config.myDefaults.user.home;
  home.stateVersion = "25.11";
}
