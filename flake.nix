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
    in {
      homeConfigurations = {
        home = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [ ./modules/home.nix ];
        };

        work = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [ ./modules/work.nix ];
        };

        server = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [ ./modules/server.nix ];
        };

        server-fat = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [ ./modules/server-fat.nix ];
        };
      };
    };
}
