{
	description = "Dotfiles & tha magic of the terminal";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
			data = builtins.fromTOML (builtins.readFile ./data.toml);
		in {
			homeConfigurations = {
				home = home-manager.lib.homeManagerConfiguration {
					pkgs = pkgs;
					modules = [ ./modules/home.nix ];
					extraSpecialArgs = { inherit data; };
				};

				work = home-manager.lib.homeManagerConfiguration {
					pkgs = pkgs;
					modules = [ ./modules/work.nix ];
					extraSpecialArgs = { inherit data; };
				};

				server = home-manager.lib.homeManagerConfiguration {
					pkgs = pkgs;
					modules = [ ./modules/server.nix ];
					extraSpecialArgs = { inherit data; };
				};

				server-fat = home-manager.lib.homeManagerConfiguration {
					pkgs = pkgs;
					modules = [ ./modules/server-fat.nix ];
					extraSpecialArgs = { inherit data; };
				};
			};
		};
}
