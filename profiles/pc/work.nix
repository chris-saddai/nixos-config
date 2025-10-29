{ lib, config, inputs, ... }:
let
  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
    config.allowUnfree = true;
    overlays = [
      inputs.hydenix.lib.overlays
      (final: prev: {
        userPkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
        };
      })
    ];
  };
in
{
  nixpkgs.pkgs = pkgs;

  imports = [
    ./hardware-configuration.nix

    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    inputs.hydenix.lib.nixOsModules

    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  boot = {
    initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "i915" "nvidia_drm" ];
    kernelParams = [ "nvidia-drm.fbdev=1" ];
  };

  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload.enable = false;
      sync.enable = true;

      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };  

  services.xserver.videoDrivers = [ "nvidia" ];

  powerManagement.resumeCommands = ''
    sleep 4

    pkill hyprlock

    hyprlock &

    # Alternativ, wenn du Hyprland benutzt:
    # Versuche den Lock-Befehl über Hyprland's IPC zu senden (häufig besser in Wayland-Setups)
    #hyprctl dispatch exec hyprlock
  '';

  environment.systemPackages = with pkgs; [
    vulkan-headers
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users."chris" = { ... }: {
      imports = [
        inputs.hydenix.lib.homeModules
        inputs.nix-index-database.hmModules.nix-index

        ./../../home/work.nix
      ];
    };
  };

  hydenix = {
    enable = true;
    hostname = "Chris-Pc";   # PC hostname
    timezone = "Europe/Berlin";
    locale = "en_US.UTF-8";
  };

  services.keyd.enable = true;
  
  environment.etc."keyd/default.conf".text = ''
    [ids]
    *

    [main]
    leftalt = leftmeta
    leftmeta = leftalt

    rightalt = layer(umlaut)

    [umlaut]
    a = macro(C-S-u 00e4 space)
    o = macro(C-S-u 00f6 space)
    u = macro(C-S-u 00fc space)
    s = macro(C-S-u 00df space)

    [umlaut+shift]
    a = macro(C-S-u 00c4 space)
    o = macro(C-S-u 00d6 space)
    u = macro(C-S-u 00dc space)
    s = macro(C-S-u 1e9e space) # ẞ '';
  
  services.xserver.xkb.extraLayouts.canary = {
    description = "Canary layout";
    languages = [ "eng" ];
    symbolsFile = ./canary; # Pfad zu deiner canary-Datei im Repo
  };

  #environment.etc."X11/xkb/symbols/canary".text = builtins.readFile ./canary;



  system.stateVersion = "25.05";
}


