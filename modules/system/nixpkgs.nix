{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    # Cachix binary caches
    substituters = [
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  # Nix ecosystem tools
  environment.systemPackages = with pkgs; [
    nix-output-monitor # Nix build output with better formatting and progress
  ];
}
