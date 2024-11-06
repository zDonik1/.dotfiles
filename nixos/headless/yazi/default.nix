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
  ];

  programs.yazi = {
    enable = true;
  };

  xdg.configFile = {
    "yazi/theme.toml".source = ./catppuccin-mocha-blue.toml;
    "yazi/catppuccin-mocha.tmTheme".source = ./catppuccin-mocha.tmTheme;
  };
}
