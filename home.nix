{ config, pkgs, ...}:

{
  home.username = "chris";
  home.homeDirectory = "/home/chris";
  
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neovim
    nodejs
    nodePackages.typescript
    nodePackages.npm
  ];

  programs.git = {
    enable = true;
    userName  = "clbaita";
    userEmail = "clbaita@outlook.com";
  };

  programs.vscode = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    # oh my zsh not found for some reason?
    #ohMyZsh = {
    #  enable = true;
    #  plugins = [ "git" "thefuck" ];
    #  theme = "robbyrussell";
    #};
  };
}
