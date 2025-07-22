{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Artemis";
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

  # Allow unfree packages (needed for 1Password)
  nixpkgs.config.allowUnfree = true;

  # Graphics support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Additional packages to help with browser compatibility
  environment.systemPackages = (import ./packages.nix { inherit pkgs inputs; }) ++ (with pkgs; [
    gvfs
    glib
    gtk3
    dbus
  ]);

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;

  users.users.rstoffel = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ tree ];
  };

  
  programs.firefox.enable = true;

  # 1Password integration
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Polkit integration for biometric unlock
    polkitPolicyOwners = [ "rstoffel" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
