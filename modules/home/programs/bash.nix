{ config, pkgs, lib, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      hi = "echo hello";
    };
  };
}
