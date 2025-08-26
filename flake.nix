{
  description = "NixOS Flake für PC und Laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # Profil für den Haupt-PC
      #"work" = nixpkgs.lib.nixosSystem {
      #  system = "x86_64-linux";
      #  modules = [
      #    ./profiles/common.nix
      #    ./profiles/work/profile.nix
      #    ./hardware/pc.nix
      #  ];
      #};
      
      #"cas" = nixpkgs.lib.nixosSystem {
      #  system = "x86_64-linux";
      #  modules = [
      #    ./profiles/common.nix
      #    ./profiles/cas/profile.nix
      #    ./hardware/pc.nix
      #  ];
      #};
      
      #"lsw" = nixpkgs.lib.nixosSystem {
      #  system = "x86_64-linux";
      #  modules = [
      #    ./profiles/common.nix
      #    ./profiles/lsw/profile.nix
      #    ./hardware/pc.nix
      #  ];
      #};
      
      # Profil für den Laptop
      "uni" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./profiles/common.nix
          ./profiles/work/profile.nix
          ./hardware/laptop.nix
        ];
      };
    };
  };
}
