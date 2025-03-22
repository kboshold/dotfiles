{
	description = "Dotfiles & the magic of the terminal";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		flake-utils.url = "github:numtide/flake-utils";

		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, flake-utils, sops-nix, ... }@inputs:
		let
			system = builtins.currentSystem or "x86_64-linux";
			pkgs = import nixpkgs { inherit system; };
			data = builtins.fromTOML (builtins.readFile ./data.toml);

			supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
			forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
		in {
			nixosConfigurations = {
				laptop = nixpkgs.lib.nixosSystem {
					system = "x86_64-linux";
					modules = [
						./systems/home/laptop.nix
						home-manager.nixosModules.home-manager
						sops-nix.nixosModules.sops
						{
							_module.args = { inherit data inputs; };
						}
					];
				};

				desktop = nixpkgs.lib.nixosSystem {
					system = "x86_64-linux";
					modules = [
						./systems/home/desktop.nix
						home-manager.nixosModules.home-manager
						sops-nix.nixosModules.sops
						{
							_module.args = { inherit data inputs; };
						}
					];
				};

				work = nixpkgs.lib.nixosSystem {
					system = "x86_64-linux";
					modules = [
						./systems/work/default.nix
						home-manager.nixosModules.home-manager
						sops-nix.nixosModules.sops
						{
							_module.args = { inherit data inputs; };
						}
					];
				};
			};

			homeConfigurations = {
				wsl = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./systems/home/wsl.nix ];
					extraSpecialArgs = { inherit data; };
				};

				server-light = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./systems/server/light.nix ];
					extraSpecialArgs = { inherit data; };
				};

				server-fat = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./systems/server/server-fat.nix ];
					extraSpecialArgs = { inherit data; };
				};

				devcontainer = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./systems/server/devcontainer.nix ];
					extraSpecialArgs = { inherit data; };
				};
			};

			devShells = forAllSystems (system:
				let pkgs = nixpkgs.legacyPackages.${system};
				in {
					default = pkgs.mkShell {
						buildInputs = with pkgs; [
							git
							sops
							ssh-to-age
							age
						];
					};
				}
			);
		};
}
