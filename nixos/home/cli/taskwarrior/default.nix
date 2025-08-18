{ pkgs, lib, ... }:

{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    colorTheme = ./catppuccin.theme;
    config = {
      verbose = "no";
      uda.priority.values = "H,M,,L";
      urgency.due.coefficient = 17;
      urgency.blocking.coefficient = 4;
      urgency.user.tag.soon.coefficient = 10;
      urgency.user.project.jrn.coefficient = -1;
      urgency.uda.priority.L.coefficient = -2;

      context = {
        soon = {
          read = lib.concatStrings [
            "(tag:soon or tag:next or sched.before:eond or due.before:eond) "
            "pro.not:go pro.not:secops pro.not:scorb"
          ];
          write = "tag:soon";
        };
        go = rec {
          read = "pro:go";
          write = read;
        };
        secops = rec {
          read = "pro:secops";
          write = read;
        };
      };
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
