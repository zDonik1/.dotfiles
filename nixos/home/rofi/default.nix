{ pkgs, ... }:
let
  rofi-power-menu-script-path =
    pkgs.writeShellScriptBin "rofi-power-menu-script" (builtins.readFile ./rofi-power-menu-script)
    + "/bin/rofi-power-menu-script";

  rofi-bluetooth = pkgs.writeShellScriptBin "rofi-bluetooth" (builtins.readFile ./rofi-bluetooth);

  rofi-connman = pkgs.writeShellApplication {
    name = "rofi-connman";
    text = builtins.readFile ./rofi-connman;
    runtimeInputs = with pkgs; [ empty ];
    checkPhase = "";
    bashOptions = [ ];
  };
in
{
  home.packages = with pkgs; [
    rofi-bluetooth
    rofi-connman

    (writeShellScriptBin "rofi-power-menu" ''
      rofi -show power-menu -modi power-menu:${rofi-power-menu-script-path} -emoji-mode copy
    '')

    (writeShellScriptBin "rofi-calc" ''
      rofi -show calc -modi calc -no-show-match -no-sort -no-bold -automatic-save-to-history -hint-result "  " -hint-welcome "  " -calc-command "echo -n '{result}'" | wl-copy
    '')

    (writeShellScriptBin "rofi-emoji" ''
      rofi -show emoji -modi emoji -emoji-mode copy
    '')
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji-wayland
    ];

    font = "JetBrainsMono Nerd Font";
    terminal = "kitty";
    theme = ./catppuccin-mocha.rasi;

    extraConfig = {
      modes = [
        "combi"
        "power-menu:${rofi-power-menu-script-path}"
        "emoji"
        "calc"
      ];
      combi-modes = [
        "window"
        "drun"
        "run"
        "emoji"
      ];

      disable-history = false;
      hide-scrollbar = true;
      drun-show-actions = true;
      case-sensitive = false;

      icon-theme = "Oranchelo";
      show-icons = true;
      window-format = "{c} {w} {t}";
      display-drun = " ";
      display-run = " ";
      display-window = "󰕰 ";
      display-combi = " ";
      display-calc = "󰪚 ";
      display-emoji = " ";

      kb-remove-word-back = "Control+w,Control+BackSpace";
      kb-clear-line = "Control+l";
      kb-mode-complete = "";
    };
  };
}
