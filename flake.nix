{
  description = "jason's home config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    user = "jasonprado";
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    lib = nixpkgs.lib;
  in 
  {
    nixosConfigurations.praxis = lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./systems/praxis.nix
      ];

    };
    
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."jason-mbp2023" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit user; };
      modules = [
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user}.imports = [ ./modules/home-manager ];
          };
        }
        ./modules/dock
        {
          local.dock = (import ./modules/dock/config.nix { user = user; });
        }
        ./modules/darwin
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Matthews-MacBook-Air".pkgs;
  };
}
