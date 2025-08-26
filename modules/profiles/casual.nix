{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  envirnment.systemPackages = with pkgs; [
    lutris
  ];
}
