{ config, lib, ... }: {
	options = {
		ux = {
			symlink = {
				_type = "option";
				default = path: config.lib.file.mkOutOfStoreSymlink (toString path);
			};
		};
	};
}
