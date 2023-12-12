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
    lib = nixpkgs.lib;
  in 
  {
    nixosConfigurations.praxis = 
    let
      user = "jasonprado";
    in lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./systems/praxis.nix
        ./users/${user}/nixos.nix
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user} = (import ./users/${user}/home-manager.nix { system = "x86_64-linux"; isPersonal = true; });
          };
        }
        home-manager.nixosModules.home-manager
      ];

    };
    
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."hegemony" = 
    let
      user = "jasonprado";
    in nix-darwin.lib.darwinSystem {
      specialArgs = { inherit user; };
      modules = [
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user} = (import ./users/${user}/home-manager.nix { system = "aarch64-darwin"; isPersonal = true; });
          };
        }
        ./users/${user}/darwin
        ./users/${user}/darwin/dock
        {
          local.dock = (import ./users/${user}/darwin/dock/config.nix { user = user; });
        }
        ./users/${user}/darwin/brew
      ];
    };

    darwinConfigurations."HDWX4TX7D5" = 
    let
      user = "jason.prado";
    in nix-darwin.lib.darwinSystem {
      specialArgs = { inherit user; };
      modules = [
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user} = (import ./users/jasonprado/home-manager.nix { system = "aarch64-darwin"; isPersonal = false; });
          };
        }
        ./users/${user}/darwin
      ];
    };
  };
}
