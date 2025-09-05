{ pkgs, lib, ... }:

let
  gpuIDs = [
    "10de:2783" # Graphics
    "10de:22bc" # Audio
  ];
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "i915"
    ];

    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      # isolate the GPU
      ("vfio-pci.ids="+ lib.concatStringsSep "," gpuIDs)
    ];
  };

    hardware.opengl.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true; # UEFI-Firmware für die VM
    qemuPackage = pkgs.qemu_kvm;
  };
  programs.virt-manager.enable = true;
  programs.zsh.enable = true;
  
  services.xserver.videoDrivers = [ "modesetting" ];

  system.stateVersion = "25.05";
}
