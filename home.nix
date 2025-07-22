
{ config, pkgs, ... }:

{
  home.username = "rstoffel";
  home.homeDirectory = "/home/rstoffel";

  home.packages = with pkgs; [
    zsh
    zip
    unzip
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
  
  programs.starship.enable = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
