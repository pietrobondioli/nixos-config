{ config, pkgs, lib, ... }:

{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
}
