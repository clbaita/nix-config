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
      imagemagick
      ffmpeg
      yt-dlp
      easyeffects # pipewire manager
      amberol # audio
      vlc # video
      semgrep
      logseq
      element-desktop
      signal-desktop
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
      font = {
        package = pkgs.hack-font;
        name = "Hack";
      };
      settings = {
        wayland_titlebar_color = "background";
        linux_display_server = "wayland";
        confirm_os_window_close = 0;
        # Manual input of everforest theme here https://github.com/ewal/kitty-everforest/blob/master/themes/everforest_dark_hard.conf 
        background = "#2b3339";
        foreground = "#d3c6aa";
        cursor = "#d3c6aa";
        cursor_text_color = "#323c41";
        url_color = "#7fbbb3";
        active_border_color = "#a7c080";
        inactive_border_color = "#53605c";
        bell_border_color = "#e69875";
        visual_bell_color = "none";
        selection_foreground = "#9da9a0";
        selection_background = "#503946";
        active_tab_background = "#2b3339";
        active_tab_foreground = "#d3c6aa";
        inactive_tab_background = "#3a454a";
        inactive_tab_foreground = "#9da9a0";
        tab_bar_background = "#323c41";
        tab_bar_margin_color = "none";
        mark1_foreground = "#2b3339";
        mark1_background = "#7fbbb3";
        mark2_foreground = "#2b3339";
        mark2_background = "#d3c6aa";
        mark3_foreground = "#2b3339";
        mark3_background = "#d699b6";
        color0 = "#374247";
        color8 = "#404c51";
        color1 = "#e67e80";
        color9 = "#e67e80";
        color2 = "#a7c080";
        color10 = "#a7c080";
        color3 = "#dbbc7f";
        color11 = "#dbbc7f";
        color4 = "#7fbbb3";
        color12 = "#7fbbb3";
        color5 = "#d699b6";
        color13 = "#d699b6";
        color6 = "#83c092";
        color14 = "#83c092";
        color7 = "#859289";
        color15 = "#9da9a0";
      };
    };
  };
}
