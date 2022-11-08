{
  description = "A very basic flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };
  
  outputs = inputs @ { self, nixpkgs, home-manager }:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        jackfrost = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [ 
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.chris = {
                imports = [ ./home.nix ];
              };
            } 
          ];
        };
      };
      hmConfig = {
        jackfrost = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          username = "chris";
          homeDirectory = "/home/chris";
          configuration = {
            imports = [
              ./home.nix
            ];
          };
        }; 
      };
    };
}
