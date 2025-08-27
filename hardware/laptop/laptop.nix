{ config, pkgs, lib, ... }:

{
  import = [ ./hardware_configuration.nix];

  #AMD
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = true;

  #Nvidia
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
