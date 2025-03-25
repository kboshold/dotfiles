{ config, pkgs, lib, data, ...}:
{
	nixpkgs.config.allowUnfree = true;
	
	imports = [
		# Hardware-Konfiguration
		/etc/nixos/hardware-configuration.nix

		# Module
		../../modules/desktop/hyperland.nix
		../../modules/core/git.nix
		../../modules/development/default.nix
	];

	networking.hostName = "laptop";

	system.stateVersion = "24.11";

	users.users.${data.user.name} = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
		shell = pkgs.bash;
	};

	home-manager.users.${data.user.name} = {
		home.stateVersion = "24.11";
		home.username = data.user.name;
		home.homeDirectory = "/home/${data.user.name}";
	};
}
