{
  description = "NixOS Flake: work / freizeit / lsw / laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # oder unstable
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hydenix.url = "github:richen604/hydenix"; # HyDE via Nix
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
    # optional:
    # nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, home-manager, hydenix, ... }@inputs:
  let
    systems = [ "x86_64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

    mkSystem = { system, profile, hwFile }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; }; # falls du inputs in Modulen brauchst
        modules = [
          ./modules/common/base.nix
          (./modules/profiles + "/" + profile + ".nix")
          (./hardware + "/" + hwFile)
        ];
      };
  in {
    nixosConfigurations = {
      work = mkSystem {
        system = "x86_64-linux";
        profile = "/work";
        hwFile = "/pc/pc.nix";
      };
      freizeit = mkSystem {
        system = "x86_64-linux";
        profile = "/casual";
        hwFile = "/pc/pc.nix";

      };
      lsw = mkSystem {
        system = "x86_64-linux";
        profile = "/lsw";
        hwFile = "/pc/pc.nix";
      };
      laptop = mkSystem {
        system = "x86_64-linux";
        profile = "/work";
        hwFile = "/laptop/laptop.nix";
      };
    };
  };
}
