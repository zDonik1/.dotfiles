{ pkgs, ... }:

{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    colorTheme = ./catppuccin.theme;
    config = {
      verbose = "no";
    };
  };
}
