{ pkgs, ... }:

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
	kb_options = altwin:swap_alt_win
  touchpad {
    natural_scroll = true
  }	
}
monitor = DP-4, 1920x1080, 0x0, 1
monitor = DP-3, 1920x1080, 1920x0, 1
monitor = HDMI-A-5, 1920x1080, 3840x0, 1

env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia

cursor {
	no_hardware_cursors = true
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
      webcord.enable = true; # enable webcord module
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
