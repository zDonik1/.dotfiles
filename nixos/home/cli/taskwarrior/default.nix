{ pkgs, ... }:

{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    colorTheme = ./catppuccin.theme;
    config = {
      verbose = "no";
      uda.priority.values = "H,M,,L";
      urgency.due.coefficient = 17;
      urgency.user.project.jrn.coefficient = -1;
      urgency.uda.priority.L.coefficient = -2;
    };
  };

  home.packages = with pkgs; [ taskwarrior-tui ];

  programs.nushell.shellAliases = {
    t = "task";
    ta = "task add";
    tal = "task add dep:(task +LATEST uuids)";
    tui = "taskwarrior-tui";
  };
}
