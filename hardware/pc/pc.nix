{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  #Intel
  boot.kernelModules = [ "intel_pstate" ];
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  #Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
  }; 
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  }
}
