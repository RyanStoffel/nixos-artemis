{
  description = "Ryan Stoffel's NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    
    let
      system = "x86_64-linux";
    in {
      
      homeConfigurations.rstoffel = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          {
            home.username = "rstoffel";
            home.homeDirectory = "/home/rstoffel";
            home.stateVersion = "23.11";

            home.packages = with nixpkgs.legacyPackages.${system}; [
              zsh
              zip
              unzip
              zsh-autosuggestions
              zsh-syntax-highlighting
            ];

            programs.starship.enable = true;
            programs.home-manager.enable = true;
          }
        ];
      };

      nixosConfigurations.rstoffel = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.rstoffel = import ./home.nix;
          }
        ];

        specialArgs = {
          inherit system;
          inputs = { inherit nixpkgs home-manager; };
        };
      };
    };
}
