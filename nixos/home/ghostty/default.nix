{ ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "catppuccin-mocha";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 13;
      window-padding-x = 6;
      window-padding-y = 4;
      window-padding-balance = true;
      adjust-cell-height = -2;

      command = "$SHELL -c nu";
      macos-titlebar-style = "hidden";

      keybind = [
        "global:cmd+grave_accent=toggle_quick_terminal"
        "super+enter=unbind"
      ];
    };
    themes = {
      catppuccin-mocha =
        let
          mocha = import ../common/catppuccin-mocha.nix;
        in
        {
          background = mocha.base;
          foreground = mocha.text;
          cursor-color = mocha.rosewater;
          cursor-text = mocha.base;
          selection-background = mocha.surface-0;
          selection-foreground = mocha.text;
          palette = [
            "0=${mocha.surface-1}"
            "1=${mocha.red}"
            "2=${mocha.green}"
            "3=${mocha.yellow}"
            "4=${mocha.blue}"
            "5=${mocha.pink}"
            "6=${mocha.teal}"
            "7=${mocha.subtext-1}"
            "8=${mocha.surface-2}"
            "9=${mocha.red}"
            "10=${mocha.green}"
            "11=${mocha.yellow}"
            "12=${mocha.blue}"
            "13=${mocha.pink}"
            "14=${mocha.teal}"
            "15=${mocha.subtext-0}"
          ];
        };
    };
  };
}
