{ config, pkgs, lib, inputs, ... }:

{
  imports = [inputs.hydenix.nixosModules.default];

  hydenix = {
    enable = true;
    hostname = "Chris-Pc";
    timezone = "Europe/Berlin";
    locale = "en_US.UTF-8";

    gaming.enable = false;

  };
}
