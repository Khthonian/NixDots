{

  description = "My first Flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
    in {  
    nixosConfigurations.monice = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ 
        ./configuration.nix 
      ];
    };
    homeConfigurations.khthonian = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ 
        ./home.nix 
      ];
    };
  };

}
