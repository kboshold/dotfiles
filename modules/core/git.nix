{ config, pkgs, lib, data, ... }:
{
	programs.git = lib.optionalAttrs (data ? git) { 
		enable = true;
		userName = lib.optionalString (data.git.name != null) data.git.name;
		userEmail = lib.optionalString (data.git.email != null) data.git.email;
		extraConfig = lib.optionalAttrs (data.git.signkey != null) {
			gpg.format = "ssh";
			gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
			commit.gpgSign = true;
			tag.gpgSign = true;
			user.signingKey = "~/.ssh/gitsign.pub";
		};
	};
}
