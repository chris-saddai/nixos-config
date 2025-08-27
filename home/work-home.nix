{config, pkgs, ... }:

{
    home.packages = with pkgs; [
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
            natural_scroll = true;
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
      
      shell = {
        enable = true; # enable shell module
        zsh = {
          enable = true; # enable zsh shell
          plugins = [ "sudo" ]; # zsh plugins
          configText = ""; # zsh config text
        };
        bash.enable = false; # enable bash shell
        fish.enable = false; # enable fish shell
        pokego.enable = false; # enable Pokemon ASCII art scripts
        p10k.enable = false; # enable p10k prompt
        starship.enable = true; # enable starship prompt
      };

      terminals = {
        enable = true; # enable terminals module
        kitty = {
          enable = true; # enable kitty terminal
          configText = ""; # kitty config text
        };
      };


    };
}
