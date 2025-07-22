
{ config, pkgs, ... }:

{
  home.username = "rstoffel";
  home.homeDirectory = "/home/rstoffel";

  home.packages = with pkgs; [
    zsh
    zip
    unzip
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
  };

  programs.starship.enable = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
