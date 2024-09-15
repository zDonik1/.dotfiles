{ pkgs, ... }:

{
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
        "drun"
        "window"
        "run"
      ];
      icon-theme = "Oranchelo";
      show-icons = true;
      window-format = "{c} {w} {t}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = " ";
      display-run = " ";
      display-window = "󰕰 ";
      display-combi = " ";
      display-Network = "󰤨  Network";
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      rofi-calc = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
    })
  ];
}
