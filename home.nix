{ config, pkgs, inputs, lib, ...}:
with lib; let 
  registry = builtins.toJSON {
    flakes =
      mapAttrsToList (n: v: {
        exact = true;
        from = {
          id = n;
          type = "indirect";
        };
        to = {
          path = v.outPath;
          type = "path";
        };
      })
      inputs;
    version = 2;
  };
in {
  xdg.configFile."nix/registry.json".text = registry;
}

{
  xdg.configFile."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  home.sessionVariables = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
  
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
      userName  = "clbaita";
      userEmail = "clbaita@outlook.com";
    };

    firefox = {
      enable = true;
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
