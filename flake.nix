{
  description = "NixOS configs with multiple profiles (work, casual, lsw)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Hydenix (für Work-Profile)
    hydenix.url = "github:richen604/hydenix";

    # nix-index-database
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixos-Hardware (praktisch für Laptop/PC Hardware)
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hydenix, nix-index-database, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        # -------------------------
        # Laptop Profiles
        # -------------------------
        laptop = inputs.hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./common.nix
            ./profiles/laptop/work.nix
          ];
        };

        # -------------------------
        # Desktop Profiles
        # -------------------------
        work = inputs.hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./common.nix
            ./profiles/pc/work.nix
          ];
        };

        casual = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./common.nix
            ./profiles/pc/casual.nix
          ];
        };

        lsw = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./common.nix
            ./profiles/pc/lsw.nix
          ];
        };
      };
    };
}

