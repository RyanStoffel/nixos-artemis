{
  description = "Ryan Stoffel's NixOS Config";

  # input sources
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:youwen5/zen-browser-flake";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, home-manager, zen-browser, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    # standalone home-manager configuration
    homeConfigurations.rstoffel = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        {
          # user settings
          home.username = "rstoffel";
          home.homeDirectory = "/home/rstoffel";
          home.stateVersion = "23.11";

          # user packages
          home.packages = with nixpkgs.legacyPackages.${system}; [
            zsh
            zip
            unzip
            zsh-autosuggestions
            zsh-syntax-highlighting
          ];

          # programs
          programs.starship.enable = true;
          programs.home-manager.enable = true;
        }
      ];
    };

    # nixos system configuration
    nixosConfigurations.Artemis = nixpkgs.lib.nixosSystem {
      inherit system;
      
      # system modules
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          # home-manager integration
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
          home-manager.users.rstoffel = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];

      # special arguments passed to modules
      specialArgs = {
        inherit inputs system;
      };
    };
  };
}
