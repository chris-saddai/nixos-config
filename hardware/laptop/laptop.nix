{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix];

  #AMD
  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;

  #Nvidia
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
