{ inputs, pkgs, ... }:

{

  imports = [
    inputs.plover-flake.homeManagerModules.plover
  ];

  home.packages = with pkgs; [
    steam
    brave
    cura-appimage
    discord-canary
    tidal-hifi
    (writeShellScriptBin "kicad" ''
    export __GLX_VENDOR_LIBRARY_NAME=""
    exec ${kicad-small}/bin/kicad "$@"
    '')
    (writeShellScriptBin "arduino-ide" ''
      exec ${arduino-ide}/bin/arduino-ide --ozone-platform=x11
    '')
  ]; 

  xdg.desktopEntries = {
    "arduino-ide" = {
      name = "Arduino IDE";
      comment = "The official IDE for Arduino";
      exec = "arduino-ide";
      terminal = false;
      categories = [ "Development" "IDE" ];
      icon = "arduino-ide"; # Stelle sicher, dass dieses Icon existiert
    };
  };

  programs.plover = {
    enable = true;

    package = inputs.plover-flake.packages.${pkgs.system}.plover.withPlugins (
      ps : with ps; [
        plover-current-time
        plover-fancytext
        plover-palantype-DE
        plover-regenpfeifer
        plover-ninja
        plover_system_switcher
      ]
    );
  };
       
  hydenix.hm = {
    enable = true;

    hyprland = {
      enable = true;
      extraConfig = ''
input {
	kb_layout =canary,us,us
	kb_variant =basic,workman,colemak_dh_ortho
	kb_options =
  touchpad {
    natural_scroll = true
  }	
}
monitor = DP-4, 1920x1080, 0x0, 1
workspace = 1, monitor:DP-4
monitor = DP-3, 1920x1080, 1920x0, 1
workspace = 2, monitor:DP-3
monitor = HDMI-A-5, 1920x1080, 3840x0, 1
workspace = 3, monitor:HDMI-A-5

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
      webcord.enable = false; # enable webcord module
      vesktop.enable = false; # enable vesktop module
    };

    spotify.enable = true;

    theme = {
      enable = true;
	    active = "Green Lush";
      themes = [ "Green Lush" "Catppuccin Mocha" "Material Sakura" "Scarlet-Night"];
    };
  };
}
