{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		noctalia = {
			url = "github:noctalia-dev/noctalia-shell";
			inputs.nixpkgs.follows = "nixpkgs";
			inputs.noctalia-qs.follows = "noctalia-qs";
		};

		noctalia-qs = {
			url = "github:noctalia-dev/noctalia-qs";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
			specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
				./noctalia.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.z3co = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
