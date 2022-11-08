{ config, pkgs, ... }:
let
  ownConfig = username:
    (config.flake.nixosConfigurations.${config.networking.hostName}.config.home-manager.users.${username});
  chris = ownConfig "chris";
in {
  xdg.configFile."nix/inputs/nixpkgs".source =
    config.flake.inputs.nixpkgs.outPath;
  home.sessionVariables.NIX_PATH =
    "nixpkgs=${chris.xdg.configHome}/nix/inputs/nixpkgs\${NIX_PATH:+:$NIX_PATH}";

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
    slack
    discord
  ];

  programs = {
    git = {
      enable = true;
      userName = "clbaita";
      userEmail = "clbaita@outlook.com";
    };

    firefox = { enable = true; };

    vscode = { enable = true; };

    zsh = {
      enable = true;
      history = {
        size = 10000;
        path = "${chris.xdg.dataHome}/zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "refined";
      };
    };

    alacritty = { enable = true; };
  };
}
