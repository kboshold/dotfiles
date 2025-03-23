{ config, pkgs, lib, data, ...}:
{
	nixpkgs.config.allowUnfree = true;
	
	imports = [
		# Hardware-Konfiguration
		./hardware-configuration.nix

		# Module
		../../modules/core
		../../modules/desktop
		../../modules/development
	];

	networking.hostName = "laptop";

	system.stateVersion = "24.11";
	users.users.${data.user.name} = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
		shell = pkgs.bash;
	};

	home.stateVersion = "24.11";
	home.username = data.user.name;
	home.homeDirectory = "/home/${data.user.name}";
}
