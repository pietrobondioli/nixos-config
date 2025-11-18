{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Nix ecosystem tools
  environment.systemPackages = with pkgs; [
    nix-output-monitor # Nix build output with better formatting and progress
  ];
}
