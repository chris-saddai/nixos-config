{ config, pkgs, inputs, lib, ... }:

{
  imports = [ 
   ./hardware-configuration.nix
   inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd
   inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd
   inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-laptop
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  #AMD
  #services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;

  #AMD GPU
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
