{ pkgs, ... }:

{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    colorTheme = ./catppuccin.theme;
    config = {
      verbose = "no";
      uda.priority.values = "H,M,,L";
      urgency.uda.priority.L.coefficient = -2;
    };
  };
}
