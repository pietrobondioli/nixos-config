{
	description = "Pietro's NixOS";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.pietro = import ./home.nix; # split modules imported inside home.nix
						backupFileExtension = "backup";
						extraSpecialArgs = { inherit inputs; };
					};
				}
			];
		};
	};
}
