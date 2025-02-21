{ config, pkgs, lib, ... }:
{
	imports = [ ./base.nix ];

	fonts.fontconfig.enable = true;
	home.packages = with pkgs; [
		gh
		bat
		fzf
		ripgrep
		eza
		mise
		fish
		atuin
		nushell
		starship
		bottom
		zoxide
		# zellij
		# zsh
		nerd-fonts.jetbrains-mono
	];
	home.file = {
		".config/eza".source = ../config/eza;
		".config/atuin".source = ../config/atuin;
		".config/mise".source = ../config/mise;
		".config/nushell".source = ../config/nushell;
		".config/oh-my-posh".source = ../config/oh-my-posh;
		".config/starship.toml".source = ../config/starship/starship.toml;
		".config/zsh".source = ../config/zsh;
		".config/zellij".source = ../config/zellij;
		".config/.fdignore".source = ../config/fdignore;
		".config/.rgignore".source = ../config/rgignore;
	};

	home.activation.miseSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
		$DRY_RUN_CMD ${pkgs.mise}/bin/mise install
	'';
}
