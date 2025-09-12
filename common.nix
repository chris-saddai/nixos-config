{ pkgs, nixvim, inputs, ... }:

let
  my-nvim = nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
    inherit pkgs;

    module = {
      config = {

    	opts = {
		    shiftwidth = 2;
		    tabstop = 2;
		    expandtab = true;
		    undodir = "~/.config/nvim/undodir";
		    number = true;
		    relativenumber = false;	
      };
		
      globals.mapleader = " ";

      keymaps = [
        { mode = "n"; key = "<leader>pv"; action = "<cmd>Ex<CR>"; }
        { mode = "i"; key = "<C-c>"; action = "<Esc>"; }
        { mode = "n"; key = "<leader><leader>"; action = ":w<CR>"; }
      ];

      plugins.bufferline.enable = false;

      plugins.treesitter = {
        enable = true;
        settings = {
          ensureInstalled = [ "lua" "python" "cpp" "typescript" ];
          highlight.enable = true;
          indent.enable = true;
        };
      };

      plugins.indent-blankline.enable = true;        
	    
      plugins.lsp = {
          enable = true;
          servers = {
            #lua_ls.enable = true;
            #pyright.enable = true;
            #ts_ls.enable = true;
            #clangd.enable = true;
            harper_ls.enable = true;
          };
        };

        plugins.cmp = {
          enable = true;
          autoEnableSources = true;
          settings.sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };

        plugins.lsp-format.enable = true;
        plugins.telescope.enable = true;
        plugins.web-devicons.enable = true;

      	plugins.fugitive.enable = true;	

        plugins.lualine.enable = true;
        plugins.toggleterm.enable = true;

        colorschemes.catppuccin = {
          enable = true;
          settings = {
            flavour = "mocha";
            integrations = {
              treesitter = true;
              telescope = true;
              cmp = true;
            };
          };
        };

        colorscheme = "catppuccin";
      };
    };
    extraSpecialArgs = { inherit nixvim; };
  };
in {  
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://cache.nixos.org" ];
    auto-optimise-store = true;
  };

  time.timeZone = "Europe/Berlin";
  console.keyMap = "de";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.chris = {
    isNormalUser = true;
    initialPassword = "2712";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" "dialout" ];
    packages = with pkgs; [ my-nvim ];
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  networking.networkmanager.enable = true;

  #Grafik-Stack 
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # 32-bit für Steam/Wine
  };

  # Pre-Service Skript, das alte Backups entfernt
  systemd.tmpfiles.rules = [
    "R! /home/chris/.config/*.backup"
    "R! /home/chris/.local/share/applications/*.backup"
  ];
}

