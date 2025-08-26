{ config, pkgs, lib, ... }:
let
  # Beispiel-IDs; via `lspci -nn` ermitteln und ersetzen
  gpuIDs = [ "1002:73bf" "1002:ab28" ]; # GPU & Audio-Function
in
{
  boot.kernelParams = [
    "amd_iommu=on" "iommu=pt"
    # optional je nach Setup: "pcie_acs_override=downstream,multifunction"
  ];
  boot.initrd.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" "kvm-amd" ];
  boot.extraModprobeConfig = ''
    options vfio-pci ids=${builtins.concatStringsSep "," gpuIDs}
  '';

  virtualisation.libvirtd = {
    enable = true;
    qemu.verbatimConfig = ''
      nvram = [ "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
    '';
  };
  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [ OVMF qemu_kvm virtiofsd spice-gtk looking-glass-client ];

  # Service, der optional beim Login/Boot die Windows-VM startet (Domain-Name anpassen)
  systemd.services."windows-autostart" = {
    description = "Autostart Windows VM via libvirt";
    after = [ "libvirtd.service" "graphical.target" ];
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''${pkgs.virt-manager}/bin/virsh start windows''; # Domain-Name
      RemainAfterExit = true;
    };
  };
}
