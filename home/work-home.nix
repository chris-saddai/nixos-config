{config, pkgs, inputs, ... }:

{ 
   home-manager = {
     useGlobalPkgs = true;
     useUserPackages = true;
     extraSpecialArgs = {inherit inputs;};
     
     users."chris" = { ... }: {
     hydenix.hm = {
      enable = true;

      editors = {
        enable = true; # enable editors module
        neovim.enable = false; # enable neovim module
        vscode = {
          enable = false; # enable vscode module
          wallbash = true; # enable wallbash extension for vscode
        };
        vim.enable = true; # enable vim module
        #default = "neovim"; # default text editor
      };      

      firefox.enable = false;
      gaming.enable = false;

      hyprland.enable = false;
      
      social = {
        enable = true; # enable social module
        discord.enable = false; # enable discord module
        webcord.enable = false; # enable webcord module
        vesktop.enable = true; # enable vesktop module
      };

      spotify.enable = false;
      #theme.enable = false;
    };
   };
};
}
