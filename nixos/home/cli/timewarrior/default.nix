{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ timewarrior ];

  xdg.configFile = {
    "timewarrior/timewarrior.cfg".text = ''
      import ${config.xdg.configHome}/timewarrior/themes/catppuccin.theme

      reports.month.spacing = 0
      reports.week.spacing = 0
      reports.day.spacing = 0

      reports.month.totals = off
      reports.week.totals = off

      reports.month.summary = off
      reports.week.summary = off
    '';

    "timewarrior/themes/catppuccin.theme".text = ''
      define theme:
        description = "catppuccin.theme: A soothing theme for timewarrior"
        colors:
          # General UI color.
          exclusion = "black"
          today     = "green"
          holiday   = "magenta"
          label     = "black"
          ids       = "yellow"
          debug     = "blue"

        # Rotating Color Palette for tags. The leading zeroes allow the order to be
        # preserved.
        palette:
          color01 = "black on red"
          color02 = "black on blue"
          color03 = "black on green"
          color04 = "black on magenta"
          color05 = "black on cyan"
          color06 = "black on yellow"
          color07 = "black on white"
    '';
  };

  programs.nushell = {
    shellAliases.tw = "timew";
    extraConfig = "use ${./timewarrior.nu} *";
  };
}
