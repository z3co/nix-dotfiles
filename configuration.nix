{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  services.getty.autologinUser = "z3co";
  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "dk";
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };

  users.users.z3co = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    initialPassword = "123";
    shell = pkgs.zsh;
  };

  services.xserver.xkb.layout = "dk";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.flatpak.enable = true;
  services.kanata = {
    enable = true;
    keyboards.default.configFile = ./config/kanata/config.kbd;
  };
  services.twingate.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.zsh.enable = true;
  programs.neovim.defaultEditor = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  virtualisation.docker.enable = true;

  fonts.fontDir.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    kitty
    fzf
    zoxide
    hyprpaper
    hyprlock
    hypridle
    hyprshot
    wofi
    waybar
    banana-cursor
    mangohud
    protonup-ng
    swaynotificationcenter
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.11"; # Did you read the comment?
}
