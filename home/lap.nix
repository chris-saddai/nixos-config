{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    brave
  ];
       
  hydenix.hm = {
    enable = true;

    hyprland = {
      enable = true;
      extraConfig = ''
input {
	kb_layout = de
	kb_variant = 
	kb_options = caps:super
  touchpad {
    natural_scroll = true
  }	
}
'';
    };
    
    editors = {
      enable = true; # enable editors module
      neovim = false; # enable neovim module
      vscode = {
        enable = false; # enable vscode module
        wallbash = true; # enable wallbash extension for vscode
      };
      #default = "neovim"; # default text editor
    };

    git = {
      enable = true;
      name = "Chris";
      email = "christian@saddai.de";
    };

    firefox.enable = false;      
    social = {
      enable = true; # enable social module
      discord.enable = false; # enable discord module
      webcord.enable = false; # enable webcord module
      vesktop.enable = true; # enable vesktop module
    };

    spotify.enable = false;

    theme = {
      enable = true;
	    active = "Green Lush";
      themes = [ "Green Lush" "Catppuccin Mocha" ];
    };
  };
}
