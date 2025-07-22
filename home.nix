{ config, pkgs, inputs, ... }:

{
  home.username = "rstoffel";
  home.homeDirectory = "/home/rstoffel";

  home.packages = with pkgs; [
    zsh
    zip
    unzip
    zsh-autosuggestions
    zsh-syntax-highlighting
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
  
  programs.starship.enable = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
