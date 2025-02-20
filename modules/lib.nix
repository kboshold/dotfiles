{ config, lib, ... }: {
	options = {
		ux = {
			symlink = {
				_type = "option";
				default = path: config.lib.file.mkOutOfStoreSymlink (builtins.toString (lib.path.resolveRelative path));
			};
		};
	};
}
