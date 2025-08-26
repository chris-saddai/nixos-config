{ config, pkgs, ... }:

{
  # -----------------------------------------------------------
  # Systemd-Modul für AMD CPU-Microcode (wichtig für Stabilität)
  # -----------------------------------------------------------
  hardware.cpu.amd.updateMicrocode = true;

  # -----------------------------------------------------------
  # AMD Grafiktreiber (Mesa) und Grafikunterstützung
  # -----------------------------------------------------------
  # Grundlegende OpenGL- und Vulkan-Unterstützung aktivieren
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      mesa_dri_drivers  # Offene Grafiktreiber
      amdvlk            # Offener Vulkan-Treiber für AMD GPUs
    ];
  };

  # -----------------------------------------------------------
  # Laptop-spezifische Konfigurationen
  # -----------------------------------------------------------
  # Tastenhelligkeit, Lautstärkeregler etc.
  hardware.acpi.enable = true;

  # Touchpad-Unterstützung mit libinput (Standard in den meisten modernen Desktops)
  services.xserver.libinput.enable = true;

  # Power Management für eine längere Akkulaufzeit
  services.power-management.enable = true;
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  # -----------------------------------------------------------
  # Sound
  # -----------------------------------------------------------
  # PulseAudio für die Tonwiedergabe
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
