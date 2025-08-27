{ config, pkgs, lib, ... }:
{
  networking.hostName = "Chris";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.chris = import ./home/work-home.nix; # optional eigene HM-Datei
  };
}
