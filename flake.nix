{
  description = "Pietro's NixOS - Multi-host Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, firefox-nightly, ... }@inputs:
    let
      # Username from defaults (defined in modules/shared/defaults.nix)
      username = "pietro";

      # Helper function to create a NixOS system configuration
      mkSystem = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        # Desktop: AMD CPU + NVIDIA GPU
        desktop = mkSystem "desktop";

        # Laptop: Intel i5 + integrated graphics
        laptop = mkSystem "laptop";

        # Legacy alias for backwards compatibility
        nixos = mkSystem "desktop";
      };
    };
}
