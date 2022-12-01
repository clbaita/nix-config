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
      ripgrep
      nodejs
      nodePackages.typescript
      nodePackages.npm
      elixir # Needs to be global for vs code :(
      slack
      discord
      imagemagick
      ffmpeg
      yt-dlp
      easyeffects # pipewire manager
      mailspring # email
      amberol # audio
      vlc # video
      semgrep
      logseq
    ];
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "clbaita";
      userEmail = "clbaita@outlook.com";
    };

    firefox.enable = true;
    vscode.enable = true;

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
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    kitty = {
      enable = true;
      theme = "Ayu Mirage";
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
