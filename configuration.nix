{ config, lib, pkgs, inputs, ... }:

let
  # Import the Salesforce CLI FHS environment
  sfdx-env = import ./sfdx-fhs.nix { inherit pkgs; };
in
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

  # Docker support for Salesforce CLI alternative
  virtualisation.docker.enable = true;

  # Additional packages to help with browser compatibility + Language servers + SFDX
  environment.systemPackages = (import ./packages.nix { inherit pkgs inputs; }) ++ [
    # Existing packages
    pkgs.gvfs
    pkgs.glib
    pkgs.gtk3
    pkgs.dbus
    
    # Salesforce CLI FHS environment
    sfdx-env.sfdx-fhs
    sfdx-env.sfdx-wrapper
    sfdx-env.sf-wrapper
    sfdx-env.salesforce-cli
  ];

  # Set up environment variables for development
  environment.variables = {
    # Java environment for LSP servers
    JAVA_HOME = "${pkgs.jdk21}/lib/openjdk";
    
    # Node.js for language servers
    NODE_PATH = "${pkgs.nodejs_22}/lib/node_modules";
    
    # Python for LSP
    PYTHONPATH = "${pkgs.python313}/lib/python3.13/site-packages";
  };

  # Add development users to docker group
  users.groups.docker.members = [ "rstoffel" ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  programs.zsh.enable = true;

  users.users.rstoffel = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];  # Added docker group
    packages = with pkgs; [ tree ];
  };

  programs.steam.enable = true;
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
