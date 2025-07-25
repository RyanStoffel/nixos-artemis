{ config, lib, pkgs, inputs, ... }:
let
  # import sfdx-fhs.nix - this allows me to use the sf cli
  sfdx-env = import ./sfdx-fhs.nix { inherit pkgs; };
in
{
  # import hardware configuration
  imports = [
    ./hardware-configuration.nix
  ];

  # boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.hostName = "artemis";
  networking.networkmanager.enable = true;

  # hardware
  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # localization
  i18n.defaultLocale = "en_US.UTF-8";

  # display and window manager
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

  # audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # allow unfree packages (needed for 1password)
  nixpkgs.config.allowUnfree = true;

  # system packages
  environment.systemPackages = (import ./packages.nix { inherit pkgs inputs; }) ++ [
    # additional packages for browser compatibility + language servers + sfdx
    pkgs.gvfs
    pkgs.glib
    pkgs.gtk3
    pkgs.dbus
    sfdx-env.sfdx-fhs
    sfdx-env.sfdx-wrapper
    sfdx-env.sf-wrapper
    sfdx-env.salesforce-cli
  ];

  # programs
  programs.zsh.enable = true;
  programs.steam.enable = true;
  programs.firefox.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "rstoffel" ];
  };

  # user configuration
  users.users.rstoffel = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ tree ];
  };

  # nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # services
  services.openssh.enable = true;

  # system version
  system.stateVersion = "25.05";
}
