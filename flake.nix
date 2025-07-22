{
  description = "Ryan Stoffel's NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:youwen5/zen-browser-flake";
  };

  outputs = { nixpkgs, home-manager, zen-browser, ... }@inputs:
    
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

      nixosConfigurations.Artemis = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.rstoffel = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];

        specialArgs = {
          inherit inputs system;
        };
      };
    };
}
