{ config, pkgs, lib, ... }:

{
  #AMD
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = true;

  #Nvidia
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  }

  imports = [ ./hardware-configuration.nix ];
}
