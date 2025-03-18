{ pkgs, ... }:

{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    colorTheme = ./catppuccin.theme;
    config = {
      verbose = "no";
      uda.priority.values = "H,M,,L";
      urgency.user.project.jrn.coefficient = -1;
      urgency.uda.priority.L.coefficient = -2;
    };
  };

  home.packages = [ pkgs.timewarrior ];

  programs.nushell.shellAliases = {
    t = "task";
    ta = "task add";
    tal = "task add dep:(task +LATEST uuids)";
    tw = "timew";
  };
}
