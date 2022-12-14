{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = {
		self,
		nixpkgs,
		home-manager,
		...
	}: {
		nixosConfigurations.nixon = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./machines/desktop

				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
				}
			];
		};
	};
}
