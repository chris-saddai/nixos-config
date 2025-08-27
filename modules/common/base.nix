{ config, pkgs, lib, inputs, ... }:

let
  lunarvim-with-config = pkgs.lunarvim.override {
    globalConfig = ''
      vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader><leader>", function ()
  vim.cmd("w")
end)

--lvim.builtin.lir.active = false
lvim.builtin.bufferline.active= false
    '';
    nvimAlias = true;
  };
in {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://cache.nixos.org" ];
    auto-optimise-store = true;
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";

  users.users.chris = {
    isNormalUser = true;
    initialPassword = "2712";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ];
    packages = with pkgs; [ git lunarvim-with-config];
  };
  security.sudo.wheelNeedsPassword = false; # optional

  # services.openssh.enable = false; # optional hydenix conflict
  networking.networkmanager.enable = true;

  # Grafik-Stack (modernes Schema, ersetzt legacy hardware.opengl)
  #hardware.graphics = {
  #  enable = true;
  #  enable32Bit = true; # 32-bit für Steam/Wine
  #};

  # PipeWire Standard-Audio
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  pulse.enable = true;
  #};
}

