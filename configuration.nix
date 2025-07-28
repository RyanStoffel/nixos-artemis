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

  # AMD GPU support
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
    rocmPackages.clr.icd
  ];
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  # localization
  i18n.defaultLocale = "en_US.UTF-8";

  # display and window manager
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.xserver.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

  # audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  
  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.hack
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    pkgs.font-awesome
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # flatpak support for apps not in nixpkgs
  services.flatpak.enable = true;

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
  
  # AMD GPU control
  programs.corectrl.enable = true;

  # thunar file manager
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # user configuration
  users.users.rstoffel = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    packages = with pkgs; [ tree ];
  };

  # nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # services
  services.openssh.enable = true;

  # system version
  system.stateVersion = "25.05";
}
