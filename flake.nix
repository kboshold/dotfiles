{
	description = "Dotfiles & the magic of the terminal";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		secrets = {
			url = "path:./secrets";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, secrets ? null, home-manager, ... }:
		let
			# Use the system from the environment or default to x86_64-linux
			system = builtins.currentSystem or "x86_64-linux";
			pkgs = import nixpkgs { inherit system; };
			data = builtins.fromTOML (builtins.readFile ./data.toml);
		in {

			homeConfigurations = {
				home = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./modules/home.nix ];
					extraSpecialArgs = { inherit data secrets; };
				};

				home-wsl = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./modules/home-wsl.nix ];
					extraSpecialArgs = { inherit data secrets; };
				};

				work = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./modules/work.nix ];
					extraSpecialArgs = { inherit data secrets; };
				};

				server = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./modules/server.nix ];
					extraSpecialArgs = { inherit data secrets; };
				};

				server-fat = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./modules/server-fat.nix ];
					extraSpecialArgs = { inherit data secrets; };
				};

				codespaces = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./modules/codespaces.nix ];
					extraSpecialArgs = { inherit data secrets; };
				};
			};
		};
}
