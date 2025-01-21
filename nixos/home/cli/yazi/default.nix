{ pkgs, ... }:
let
  smart-enter-binding = on: {
    inherit on;
    run = "plugin smart-enter";
    desc = "Enter the child directory, or open the file";
  };
in
{
  home.packages = with pkgs; [
    ffmpegthumbnailer
    p7zip
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    imagemagick
  ];

  programs.yazi = {
    enable = true;
    initLua = ./init.lua;
    plugins = with pkgs.yazi-plugins; {
      inherit smart-enter;
    };

    settings = {
      manager = {
        linemode = "size_and_mtime";
        show_hidden = true;
        scrolloff = 5;
      };
    };

    keymap = {
      manager.prepend_keymap = [
        (smart-enter-binding "l")
        (smart-enter-binding "Enter")
      ];
    };
  };

  xdg.configFile = {
    "yazi/theme.toml".source = ./catppuccin-mocha-blue.toml;
    "yazi/catppuccin-mocha.tmTheme".source = ./catppuccin-mocha.tmTheme;
  };
}
