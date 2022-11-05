{ config, pkgs, ...}:

{
  home.username = "chris";
  home.homeDirectory = "/home/chris";
  
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neovim
  ];

  programs.git = {
    enable = true;
    userName  = "clbaita";
    userEmail = "clbaita@outlook.com";
  };
}
