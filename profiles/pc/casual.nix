{ inputs, ... }:
let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  nixpkgs.pkgs = pkgs;

  imports = [
    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-hardware.nixosModules.common-pc-desktop
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
  ];
 
  # Desktop Environment
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  # Nvidia Treiber (falls du Wayland in KDE nutzen willst: PRIME + GBM einstellen)
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false; # besser kompatibel für Gaming
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Steam & Gaming global verfügbar
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    mangohud 
    bottles
    protonup-qt
  ];

  # Home-Manager Integration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users."chris" = { ... }: {
      imports = [
        ./../../home/casual.nix
      ];
    };  
  };

  networking.hostName = "Chris-Pc";

  system.stateVersion = "25.05";
}

