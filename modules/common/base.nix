{ config, pkgs, lib, inputs, ... }:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://cache.nixos.org" ];
    auto-optimise-store = true;
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";

  users.users.chris = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ];
    packages = with pkgs; [ git ];
  };
  security.sudo.wheelNeedsPassword = false; # optional

  services.openssh.enable = false; # optional
  networking.networkmanager.enable = true;

  # Grafik-Stack (modernes Schema, ersetzt legacy hardware.opengl)
  #hardware.graphics = {
  #  enable = true;
  #  enable32Bit = true; # 32-bit für Steam/Wine
  #};

  # PipeWire Standard-Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}

