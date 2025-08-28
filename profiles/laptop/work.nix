{ inputs, ... }:
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
    # Hydenix modules
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    inputs.hydenix.lib.nixOsModules
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    ./hardware-configuration.nix

    # evtl. weitere Custom-Module: ./modules/system ./modules/hm
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users."chris" = { ... }: {
      imports = [
        inputs.hydenix.lib.homeModules
        inputs.nix-index-database.hmModules.nix-index
        ./../../home/lap.nix
      ];
    };
  };

  hydenix = {
    enable = true;
    hostname = "Chris-Laptop";   # anpassen
    timezone = "Europe/Berlin";
    locale = "de_DE.UTF-8";
  };

  system.stateVersion = "25.05";
}

