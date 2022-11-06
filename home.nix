{ config, pkgs, ...}:

{
  home.username = "chris";
  home.homeDirectory = "/home/chris";
  
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neovim
    neofetch
    nodejs
    nodePackages.typescript
    nodePackages.npm
    brave
    slack
    discord
  ];

  programs = {
    git = {
      enable = true;
      userName  = "clbaita";
      userEmail = "clbaita@outlook.com";
    };

    vscode = {
      enable = true;
    };

    zsh = {
      enable = true;
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "refined";
      };
    };

    alacritty = {
      enable = true;
    };
  };
}
