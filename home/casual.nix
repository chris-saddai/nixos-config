{ pkgs, ... }:

{
  home.packages = with pkgs; [
    webcord
    brave
  ];
  
  programs.git = {
    enable = true;
    userName = "Chris";
    userEmail = "christian@saddai";
  };

}
