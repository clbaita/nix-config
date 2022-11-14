{ config, pkgs, ... }:
let
  userConfig = username:
    (config.flake.nixosConfigurations.${config.networking.hostName}.config.home-manager.users.${username});
  username = "chris";
  chris = userConfig username;
in {

  xdg.configFile."nix/inputs/nixpkgs".source =
    config.flake.inputs.nixpkgs.outPath;

  home.sessionVariables = {
    NIX_PATH =
      "nixpkgs=${chris.xdg.configHome}/nix/inputs/nixpkgs\${NIX_PATH:+:$NIX_PATH}";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";

    packages = with pkgs; [
      neovim
      neofetch
      nodejs
      nodePackages.typescript
      nodePackages.npm
      slack
      discord
      vlc
      imagemagick
      ffmpeg
      youtube-dl
    ];
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "clbaita";
      userEmail = "clbaita@outlook.com";
    };

    # TODO: Need to check if gnome has xdg portal by default
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        forceWayland = true;
        extraPolicies = { ExtensionSettings = { }; };
      };
    };

    vscode = { enable = true; };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

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

    kitty = {
      enable = true;
      theme = "Space Gray Eighties";
      font = {
        package = (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; });
        name = "Iosevka";
      };
      settings = {
        wayland_titlebar_color = "background";
        linux_display_server = "wayland";
        confirm_os_window_close = 0;
      };
    };
  };
}
