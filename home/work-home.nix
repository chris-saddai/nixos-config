{config, pkgs, inputs, ... }:

{ 
    hydenix.hm = {
      enable = true;

      editors = {
        enable = true; # enable editors module
        neovim = false; # enable neovim module
        vscode = {
          enable = false; # enable vscode module
          wallbash = true; # enable wallbash extension for vscode
        };
        #default = "neovim"; # default text editor
      };      

      firefox.enable = false;

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
}
