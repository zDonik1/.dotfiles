{ pkgs, config, ... }:
let
  layouts = import ./layouts.nix {
    inherit config;
    inherit (pkgs) zjstatus;
  };
in
{
  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "nu";
      advanced_mouse_actions = false;
      ui.pane_frames.rounded_corners = true;

      plugins =
        let
          definePlugin =
            name: attrs:
            {
              _props = {
                location = "zellij:${name}";
              };
            }
            // attrs;
        in
        {
          tab-bar = definePlugin "tab-bar" { };
          status-bar = definePlugin "status-bar" { };
          strider = definePlugin "strider" { };
          compact-bar = definePlugin "compact-bar" { };
          session-manager = definePlugin "session-manager" { };
          welcome-screen = definePlugin "session-manager" { welcome_screen = true; };
          filepicker = definePlugin "strider" { cwd = "/"; };
        };

      keybinds =
        let
          mkKeybind = keys: actions: {
            bind = {
              _args = keys;
              _children = actions;
            };
          };
        in
        {
          _props.clear-defaults = true;

          normal._children = [
            (mkKeybind [ "Ctrl Space" ] [ { SwitchToMode = "tmux"; } ])
            (mkKeybind
              [ "Ctrl g" ]
              [
                { ToggleFocusFullscreen = { }; }
                { SwitchFocus = { }; }
              ]
            )

            (mkKeybind [ "Ctrl 1" ] [ { GoToTab = 1; } ])
            (mkKeybind [ "Ctrl 2" ] [ { GoToTab = 2; } ])
            (mkKeybind [ "Ctrl 3" ] [ { GoToTab = 3; } ])
            (mkKeybind [ "Ctrl 4" ] [ { GoToTab = 4; } ])
            (mkKeybind [ "Ctrl 5" ] [ { GoToTab = 5; } ])
            (mkKeybind [ "Ctrl 6" ] [ { GoToTab = 6; } ])
            (mkKeybind [ "Ctrl 7" ] [ { GoToTab = 7; } ])
            (mkKeybind [ "Ctrl 8" ] [ { GoToTab = 8; } ])
            (mkKeybind [ "Ctrl 9" ] [ { GoToTab = 9; } ])

            (mkKeybind [ "Alt h" "Alt Left" ] [ { MoveFocus = "Left"; } ])
            (mkKeybind [ "Alt l" "Alt Right" ] [ { MoveFocus = "Right"; } ])
            (mkKeybind [ "Alt j" "Alt Down" ] [ { MoveFocus = "Down"; } ])
            (mkKeybind [ "Alt k" "Alt Up" ] [ { MoveFocus = "Up"; } ])

            (mkKeybind [ "Ctrl Alt Shift h" "Ctrl Alt Shift Left" ] [ { Resize = "Left"; } ])
            (mkKeybind [ "Ctrl Alt Shift l" "Ctrl Alt Shift Right" ] [ { Resize = "Right"; } ])
            (mkKeybind [ "Ctrl Alt Shift j" "Ctrl Alt Shift Down" ] [ { Resize = "Down"; } ])
            (mkKeybind [ "Ctrl Alt Shift k" "Ctrl Alt Shift Up" ] [ { Resize = "Up"; } ])
            (mkKeybind [ "Ctrl Alt Shift =" "Ctrl Alt Shift +" ] [ { Resize = "Increase"; } ])
            (mkKeybind [ "Ctrl Alt Shift -" ] [ { Resize = "Decrease"; } ])

            (mkKeybind [ "Alt [" ] [ { PreviousSwapLayout = { }; } ])
            (mkKeybind [ "Alt ]" ] [ { NextSwapLayout = { }; } ])

            (mkKeybind [ "Ctrl Down" ] [ { ScrollDown = { }; } ])
            (mkKeybind [ "Ctrl Up" ] [ { ScrollUp = { }; } ])
            (mkKeybind [ "Ctrl PageDown" ] [ { HalfPageScrollDown = { }; } ])
            (mkKeybind [ "Ctrl PageUp" ] [ { HalfPageScrollUp = { }; } ])
            (mkKeybind [ "Ctrl Alt e" ] [ { EditScrollback = { }; } ])
          ];

          # tmux mode is taken for all bindings with prefixes
          tmux._children = [
            # tabs
            (mkKeybind [ "t" ] [ { SwitchToMode = "tab"; } ])
            (mkKeybind
              [ "[" ]
              [
                { GoToPreviousTab = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "]" ]
              [
                { GoToNextTab = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "Tab" ]
              [
                { ToggleTab = { }; }
                { SwitchToMode = "normal"; }
              ]
            )

            # panes
            (mkKeybind [ "p" ] [ { SwitchToMode = "pane"; } ])
            (mkKeybind [ "r" ] [ { SwitchToMode = "resize"; } ])
            (mkKeybind
              [ "Space" "Ctrl Space" ]
              [
                { SwitchFocus = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "Ctrl Space" ]
              [
                { SwitchFocus = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "z" ]
              [
                { ToggleFocusFullscreen = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "f" "Ctrl f" ]
              [
                { ToggleFloatingPanes = { }; }
                { SwitchToMode = "normal"; }
              ]
            )

            # sessions
            (mkKeybind [ "d" ] [ { Detach = { }; } ])
            (mkKeybind [ "q" ] [ { Quit = { }; } ])
            (mkKeybind
              [ "n" ]
              [
                {
                  LaunchOrFocusPlugin = {
                    _args = [ "session-manager" ];
                    floating = true;
                    move_to_focused_tab = true;
                  };
                }
                {
                  SwitchToMode = "normal";
                }
              ]
            )

            # search/scroll
            (mkKeybind [ "s" ] [ { SwitchToMode = "scroll"; } ])
          ];

          tab._children = [
            (mkKeybind [ "p" ] [ { SwitchToMode = "renamepane"; } ])
            (mkKeybind
              [ "t" ]
              [
                { NewTab = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "w" ]
              [
                { CloseTab = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "[" ]
              [
                { MoveTab = "Left"; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "]" ]
              [
                { MoveTab = "Right"; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "Tab" ]
              [
                { ToggleTab = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind [ "r" ] [ { SwitchToMode = "renametab"; } ])
          ];

          pane._children = [
            (mkKeybind
              [ "p" ]
              [
                { NewPane = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "s" ]
              [
                { NewPane = "Down"; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "d" ]
              [
                { NewPane = "Right"; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "w" ]
              [
                { CloseFocus = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "z" ]
              [
                { TogglePaneFrames = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "f" ]
              [
                { ToggleFloatingPanes = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "e" ]
              [
                { TogglePaneEmbedOrFloating = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "r" ]
              [
                { SwitchToMode = "RenamePane"; }
                { PaneNameInput = 0; }
              ]
            )

            (mkKeybind
              [ "Tab" ]
              [
                { MovePane = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "m" ]
              [
                { MovePaneBackwards = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "h" "Left" ]
              [
                { MovePane = "Left"; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "j" "Down" ]
              [
                { MovePane = "Down"; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "k" "Up" ]
              [
                { MovePane = "Up"; }
                { SwitchToMode = "normal"; }
              ]
            )
            (mkKeybind
              [ "l" "Right" ]
              [
                { MovePane = "Right"; }
                { SwitchToMode = "normal"; }
              ]
            )
          ];

          resize._children = [
            (mkKeybind [ "h" "Left" ] [ { Resize = "Increase Left"; } ])
            (mkKeybind [ "j" "Down" ] [ { Resize = "Increase Down"; } ])
            (mkKeybind [ "k" "Up" ] [ { Resize = "Increase Up"; } ])
            (mkKeybind [ "l" "Right" ] [ { Resize = "Increase Right"; } ])
            (mkKeybind [ "H" ] [ { Resize = "Decrease Left"; } ])
            (mkKeybind [ "J" ] [ { Resize = "Decrease Down"; } ])
            (mkKeybind [ "K" ] [ { Resize = "Decrease Up"; } ])
            (mkKeybind [ "L" ] [ { Resize = "Decrease Right"; } ])
            (mkKeybind [ "=" "+" ] [ { Resize = "Increase"; } ])
            (mkKeybind [ "-" ] [ { Resize = "Decrease"; } ])
          ];

          scroll._children = [
            (mkKeybind
              [ "f" ]
              [
                { SwitchToMode = "entersearch"; }
                { SearchInput = 0; }
              ]
            )
            (mkKeybind [ "j" "Down" ] [ { ScrollDown = { }; } ])
            (mkKeybind [ "k" "Up" ] [ { ScrollUp = { }; } ])
            (mkKeybind [ "d" "t" ] [ { HalfPageScrollDown = { }; } ])
            (mkKeybind [ "u" "s" ] [ { HalfPageScrollUp = { }; } ])
            (mkKeybind [ "PageDown" "Right" "l" ] [ { PageScrollDown = { }; } ])
            (mkKeybind [ "PageUp" "Left" "h" ] [ { PageScrollUp = { }; } ])
            (mkKeybind
              [ "e" ]
              [
                { EditScrollback = { }; }
                { SwitchToMode = "Normal"; }
              ]
            )

            (mkKeybind [ "n" ] [ { Search = "down"; } ])
            (mkKeybind [ "N" ] [ { Search = "up"; } ])
            (mkKeybind [ "c" ] [ { SearchToggleOption = "CaseSensitivity"; } ])
            (mkKeybind [ "w" ] [ { SearchToggleOption = "Wrap"; } ])
            (mkKeybind [ "o" ] [ { SearchToggleOption = "WholeWord"; } ])
          ];

          entersearch._children = [
            (mkKeybind [ "Enter" ] [ { SwitchToMode = "scroll"; } ])
          ];

          shared_except = {
            _args = [ "normal" ];
            _children = [
              (mkKeybind [ "Esc" ] [ { SwitchToMode = "normal"; } ])
            ];
          };

          renametab._children = [
            (mkKeybind [ "Enter" ] [ { SwitchToMode = "normal"; } ])
            (mkKeybind
              [ "Esc" ]
              [
                { UndoRenameTab = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
          ];

          renamepane._children = [
            (mkKeybind [ "Enter" ] [ { SwitchToMode = "normal"; } ])
            (mkKeybind
              [ "Esc" ]
              [
                { UndoRenamePane = { }; }
                { SwitchToMode = "normal"; }
              ]
            )
          ];
        };
    };

    themes = {
      catppuccin-mocha = ./catppuccin-mocha.kdl;
    };

    layouts = {
      inherit (layouts) default time ledger;

      "default.swap" = layouts.defaultSwap;
      "time.swap" = layouts.defaultSwap;
      "ledger.swap" = layouts.defaultSwap;
    };
  };
}
