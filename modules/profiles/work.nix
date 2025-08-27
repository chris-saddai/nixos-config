{ config, pkgs, lib, inputs, ... }:

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
  imports = [
    inputs.hydenix.lib.nixOsModules
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs.pkgs = pkgs;
  
  home-manager = {
   useGlobalPkgs = true;
   useUserPackages = true;
   extraSpecialArgs = {inherit inputs;};
   users."chris" = { ... }: {
    imports = [
     inputs.hydenix.lib.homeModules
     inputs.nix-index-database.hmModules.nix-index
     ./../../home/work-home.nix
    ];
   };
  };  

  hydenix = {
    enable = true;
    hostname = "Chris-Pc";
    timezone = "Europe/Berlin";
    locale = "en_US.UTF-8";

    gaming.enable = false;

  };
}
