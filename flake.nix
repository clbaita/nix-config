{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager }:
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
          modules = [
            { config._module.args.flake = self; }
            ./configuration.nix
            home-manager.nixosModules.home-manager
          ];
        };
      };
      hmConfig = {
        jackfrost = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          extraSpecialArgs = { inherit inputs; };
          username = "chris";
          homeDirectory = "/home/chris";
          configuration = { imports = [ ./home.nix ]; };
        };
      };
    };
}
