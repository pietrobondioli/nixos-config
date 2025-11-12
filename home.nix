{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./modules/home/identity.nix
    ./modules/home/packages/core.nix
    ./modules/home/packages/dev.nix
    ./modules/home/packages/desktop.nix
    ./modules/home/packages/fonts.nix
    ./modules/home/programs/bash.nix
    ./modules/home/programs/obs.nix
    ./modules/home/programs/ssh.nix
    ./modules/home/programs/git.nix
    ./modules/home/programs/waybar.nix
    ./modules/home/programs/rofi.nix
    ./modules/home/programs/kitty.nix
    ./modules/home/programs/zsh.nix
    ./modules/home/programs/zen-browser.nix
    ./modules/home/programs/zoxide.nix
    ./modules/home/programs/direnv.nix
    ./modules/home/services/mako.nix
    ./modules/home/services/cliphist.nix
    ./modules/home/services/gammastep.nix
    ./modules/home/services/swayidle.nix
    ./modules/home/theming/cursor.nix
    ./modules/home/theming/gtk.nix
    ./modules/home/theming/qt.nix
    ./modules/home/theming/session.nix
    ./modules/home/theming/xdg.nix
    ./modules/home/config/files.nix
  ];
}
