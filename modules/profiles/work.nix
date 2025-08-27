{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.hydenix.lib.nixOsModules
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
  ];

  hydenix = {
    enable = true;
    hostname = "Chris-Pc";
    timezone = "Europe/Berlin";
    locale = "en_US.UTF-8";

    gaming.enable = false;

  };
}
