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
#     pkgs = import nixpkgs {
#         inherit system;
#
#         config = {
#           allowUnfree = true;
#         };
#       };
    lib = nixpkgs.lib;
  in 
  {
    nixosConfigurations.praxis = lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./systems/praxis.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user}.imports = [
              (
                import ./modules/home-manager { system = "x86_64-linux"; }
              )
            ];
          };
        }
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
  };
}
