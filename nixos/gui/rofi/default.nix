{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "rofi-calc" ''
      rofi -show calc -modi calc -no-show-match -no-sort -no-bold -automatic-save-to-history -hint-result "  " -hint-welcome "  " -calc-command "echo -n '{result}'" | wl-copy
    '')
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [ rofi-calc ];

    font = "JetBrainsMono Nerd Font";
    terminal = "kitty";
    theme = ./catppuccin-mocha.rasi;

    extraConfig = {
      modes = [ "combi" ];
      combi-modes = [
        "window"
        "drun"
        "run"
      ];

      disable-history = false;
      hide-scrollbar = true;
      drun-show-actions = true;

      icon-theme = "Oranchelo";
      show-icons = true;
      window-format = "{c} {w} {t}";
      display-drun = " ";
      display-run = " ";
      display-window = "󰕰 ";
      display-combi = " ";
      display-calc = "󰪚 ";
      display-Network = "󰤨  Network";

      kb-remove-word-back = "Control+w,Control+BackSpace";
      kb-clear-line = "Control+l";
      kb-mode-complete = "";
    };
  };
}
