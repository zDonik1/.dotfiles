{ pkgs, ... }:

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
    exiftool
  ];

  programs.yazi = {
    enable = true;
    initLua = ./init.lua;
    shellWrapperName = "y";

    settings = {
      manager = {
        linemode = "size_and_mtime";
        show_hidden = true;
        scrolloff = 5;
      };
    };
  };

  xdg.configFile = {
    "yazi/theme.toml".source = ./catppuccin-mocha-blue.toml;
    "yazi/catppuccin-mocha.tmTheme".source = ./catppuccin-mocha.tmTheme;
  };
}
