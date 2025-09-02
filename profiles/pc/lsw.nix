{ pkgs, lib, config, ... }:

let
  gpuIDs = [
    "10de:2783" # Graphics
    "10de:22bc" # Audio
  ];
in
{
  options.vfio.enable = with lib;
    mkEnableOption "Configure the machine for VFIO";
  
  config = let cfg = config.vfio;
  in {
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        "vfio_virqfd"

        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];

      kernelParams = [
        "intel_iommu=on"
      ] ++ lib.optional cfg.enable
        # isolate the GPU
        ("vfio-pci.ids="+ lib.concatStringsSep "," gpuIDs);
    };

    hardware.opengl.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

  };

  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true; # UEFI-Firmware für die VM
    qemuPackage = pkgs.qemu_kvm;
  };
  programs.virt-manager.enable = true;
  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}

