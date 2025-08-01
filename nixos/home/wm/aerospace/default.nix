{
  pkgs,
  lib,
  config,
  ...
}:
let
  ghosttyNewWindow = pkgs.writeScriptBin "ghostty-new-window" ''
    #!/usr/bin/osascript

    set termName to "Ghostty"

    tell application termName
        if it is running
            tell application "System Events" to tell process termName
                click menu item "New Window" of menu "File" of menu bar 1
            end tell
        else
            activate
        end if
    end tell
  '';
in
{
  programs.aerospace = {
    enable = true;
    userSettings = {
      start-at-login = true;
      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.top = 8;
        outer.bottom = 8;
        outer.left = 8;
        outer.right = 8;
      };
      on-window-detected = [ { run = [ "layout floating" ]; } ];

      mode.main.binding =
        {
          # All possible keys:
          # - Letters.        a, b, c, ..., z
          # - Numbers.        0, 1, 2, ..., 9
          # - Keypad numbers. keypad0, keypad1, keypad2, ..., keypad9
          # - F-keys.         f1, f2, ..., f20
          # - Special keys.   minus, equal, period, comma, slash, backslash, quote, semicolon,
          #                   backtick, leftSquareBracket, rightSquareBracket, space, enter, esc,
          #                   backspace, tab, pageUp, pageDown, home, end, forwardDelete,
          #                   sectionSign (ISO keyboards only, european keyboards only)
          # - Keypad special. keypadClear, keypadDecimalMark, keypadDivide, keypadEnter, keypadEqual,
          #                   keypadMinus, keypadMultiply, keypadPlus
          # - Arrows.         left, down, up, right

          # All possible modifiers: cmd, alt, ctrl, shift

          # All possible commands: https://nikitabobko.github.io/AeroSpace/commands

          # See: https://nikitabobko.github.io/AeroSpace/commands#layout
          alt-t = "layout tiles horizontal vertical";
          alt-a = "layout accordion horizontal vertical";
          alt-f = "layout floating tiling";

          # See: https://nikitabobko.github.io/AeroSpace/commands#focus
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";

          # See: https://nikitabobko.github.io/AeroSpace/commands#move
          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          # See: https://nikitabobko.github.io/AeroSpace/commands#resize
          alt-minus = "resize smart -50";
          alt-equal = "resize smart +50";

          # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";
          alt-7 = "workspace 7";
          alt-8 = "workspace 8";
          alt-9 = "workspace 9";

          # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";
          alt-shift-6 = "move-node-to-workspace 6";
          alt-shift-7 = "move-node-to-workspace 7";
          alt-shift-8 = "move-node-to-workspace 8";
          alt-shift-9 = "move-node-to-workspace 9";

          # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
          alt-tab = "workspace-back-and-forth";
          # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
          alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

          # See: https://nikitabobko.github.io/AeroSpace/commands#mode
          alt-shift-s = "mode service";
        }
        // lib.optionalAttrs config.programs.ghostty.enable {
          cmd-enter = "exec-and-forget ${ghosttyNewWindow}/bin/ghostty-new-window";
        };

      mode.service.binding = {
        esc = [
          "reload-config"
          "mode main"
        ];
        r = [
          "flatten-workspace-tree"
          "mode main"
        ]; # reset layout
        backspace = [
          "close-all-windows-but-current"
          "mode main"
        ];

        # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
        #s = ["layout sticky tiling", "mode main"]

        alt-shift-h = [
          "join-with left"
          "mode main"
        ];
        alt-shift-j = [
          "join-with down"
          "mode main"
        ];
        alt-shift-k = [
          "join-with up"
          "mode main"
        ];
        alt-shift-l = [
          "join-with right"
          "mode main"
        ];

        down = "volume down";
        up = "volume up";
        shift-down = [
          "volume set 0"
          "mode main"
        ];
      };
    };
  };
}
