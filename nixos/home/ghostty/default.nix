{ ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "catppuccin-mocha";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 11;
      window-padding-x = 6;
      window-padding-y = 4;
      window-padding-balance = true;
      adjust-cell-height = -2;

      command = "$SHELL -c nu";
      macos-titlebar-style = "hidden";

      keybind = [
        "global:cmd+grave_accent=toggle_quick_terminal"
      ];
    };
    themes = {
      catppuccin-mocha = {
        background = "1e1e2e";
        foreground = "cdd6f4";
        cursor-color = "f5e0dc";
        cursor-text = "1e1e2e";
        selection-background = "353749";
        selection-foreground = "cdd6f4";
        palette = [
          "0=#45475a"
          "1=#f38ba8"
          "2=#a6e3a1"
          "3=#f9e2af"
          "4=#89b4fa"
          "5=#f5c2e7"
          "6=#94e2d5"
          "7=#bac2de"
          "8=#585b70"
          "9=#f38ba8"
          "10=#a6e3a1"
          "11=#f9e2af"
          "12=#89b4fa"
          "13=#f5c2e7"
          "14=#94e2d5"
          "15=#a6adc8"
        ];
      };
    };
  };
}
