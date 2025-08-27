{ config, pkgs, lib, ... }:
{
  networking.hostName = "Chris-laptop";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
#    users.chris = import ./work-home.nix; 
  };
}
