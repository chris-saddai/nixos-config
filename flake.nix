{
  description = "NixOS Flake: work / freizeit / lsw / laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # oder unstable
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hydenix.url = "github:richen604/hydenix"; # HyDE via Nix
    # optional:
    # nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, home-manager, hydenix, ... }@inputs:
  let
    systems = [ "x86_64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

    mkSystem = { system, hostname, profile, hwFile }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; }; # falls du inputs in Modulen brauchst
        modules = [
          ./modules/common/base.nix
	  ./modules/hm/${profile}.nix
          (./modules/profiles + "/" + profile + ".nix")
          (./hosts + "/" + profile + ".nix")
          (./hardware + "/" + hwFile)
          # Home-Manager systemweit einbinden
          home-manager.nixosModules.home-manager{
	    home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	    home-manager.users.chris = import ./home/work-home.nix;
          }
        ];
      };
  in {
    nixosConfigurations = {
      work = mkSystem {
        system = "x86_64-linux";
        hostname = "Chris-PC";
        profile = "/work";
        hwFile = "/pc/pc.nix";
      };
      freizeit = mkSystem {
        system = "x86_64-linux";
        hostname = "Chris-PC";
        profile = "/casual";
        hwFile = "/pc/pc.nix";

      };
      lsw = mkSystem {
        system = "x86_64-linux";
        hostname = "Chris-PC";
        profile = "/lsw";
        hwFile = "/pc/pc.nix";
      };
      laptop = mkSystem {
        system = "x86_64-linux";
        hostname = "Chris-laptop";
        profile = "/work";
        hwFile = "/laptop/laptop.nix";
      };
    };
  };
}
