{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
    brave
  ];

  programs.git = {
    enable = true;
    userName = "Chris";
    userEmail = "christian@saddai";
  };

  home.stateVersion = "25.05";
}
