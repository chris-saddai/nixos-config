{ config, pkgs, ... }:

{
  users.users.chris = {
    isNormalUser = true;
    initialPassword = "2712";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    lunarvim
  ];
  
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.lader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keymap = "de";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
