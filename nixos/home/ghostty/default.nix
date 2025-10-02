{ ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
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
  };
}
