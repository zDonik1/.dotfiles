{ config, pkgs, ... }:
let
  catppuccin-mocha-conf = "hypr/catppuccin-mocha.conf";
in
{
  imports = [
    ../hypridle
    ../hyprpaper
    ../kitty
    ../rofi
    ../keepmenu
  ];

  home = {
    packages = with pkgs; [
      qt5.qtwayland
      qt6.qtwayland
      grimblast
      wl-clipboard

      (writeShellScriptBin "disable-laptop-monitor" ''
        hyprctl keyword monitor eDP-1, disable
      '')

      (writeShellScriptBin "enable-laptop-monitor" ''
        hyprctl keyword monitor eDP-1, preferred, auto-left, 1.25
      '')
    ];
  };

  xdg.configFile = {
    "${catppuccin-mocha-conf}".source = ./catppuccin-mocha.conf;
  };

  services = {
    udiskie.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      source = [
        (config.xdg.configHome + "/" + catppuccin-mocha-conf)
      ];

      debug = {
        # overlay = true;
        # disable_logs = false;
      };

      monitor = [
        "DP-1, preferred, 0x0, 1"
        "eDP-1, preferred, auto-left, 1.25"
        ", preferred, auto, 1"
      ];

      workspace = [
        "1, monitor:DP-1, default:true"
      ];

      env = [
        "XCURSOR_SIZE, 12"
        "HYPRCURSOR_SIZE, 12"
        "LIBVA_DRIVER_NAME, nvidia"
        "GBM_BACKEND, nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME, nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      "cursor:no_hardware_cursors" = true;

      exec-once = [
        # "sleep 2; disable-laptop-monitor"
        "zellij kill-all-sessions -y" # ensure old env vars arent saved in zellij

        "systemctl --user start plasma-polkit-agent"
        "hypridle"
        "hyprpaper"
        "syncthing --no-browser &"

        "hyprctl dispatch workspace 1"
        "firefox"
        "[workspace 4 silent] kitty zellij attach -c config"
        "[workspace special:magic silent] telegram-desktop"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        resize_on_border = true;
        border_size = 2;

        "col.active_border" = "$blue";
        "col.inactive_border" = "$overlay0";
      };

      decoration = {
        rounding = 10;
        # active_opacity = 0.9
        # inactive_opacity = 0.9;
        # blur = {
        #   enabled = true;
        #   size = 5;
        #   passes = 1;
        #   vibrancy = 0.2;
        # };

        shadow = {
          enabled = true;
          color = "$mantle";
        };
      };

      misc = {
        force_default_wallpaper = 0;
        key_press_enables_dpms = true;
        focus_on_activate = true;
        animate_manual_resizes = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, X, killactive,"
        "$mainMod SHIFT, Q, exit"
        "$mainMod, U, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, F, fullscreen, 1"
        "$mainMod, W, centerwindow, 1"
        "$mainMod SHIFT, F, fullscreen, 0"

        "$mainMod, A, exec, grimblast --freeze copysave area"
        "$mainMod SHIFT, U, exec, grimblast copysave output"

        "$mainMod, T, exec, kitty"
        "$mainMod, L, exec, telegram-desktop"
        "CTRL, space, exec, rofi -show combi"
        "$mainMod, P, exec, rofi-power-menu"
        "$mainMod, N, exec, rofi-connman"
        "$mainMod, B, exec, rofi-bluetooth"
        "$mainMod, E, exec, rofi-calc"
        "$mainMod, K, exec, keepmenu"

        "$mainMod, space, cyclenext,"
        "$mainMod SHIFT, space, cyclenext, prev"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        "$mainMod CTRL, left, resizeactive, -5% 0"
        "$mainMod CTRL, right, resizeactive, 5% 0"
        "$mainMod CTRL, up, resizeactive, 0 -5%"
        "$mainMod CTRL, down, resizeactive, 0 5%"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, I, togglespecialworkspace, magic"
        "$mainMod SHIFT, I, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, F1, pass, ^(com\.obsproject\.Studio)$"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"

        "float, class:(thunderbird), title:^$"
        "float, class:(org.gnome.Loupe)"
        "float, class:(org.keepassxc.KeePassXC)"

        "pseudo, class:(kitty)"
        "size 75% 90%, class:(kitty)"

        "float, class:(org.telegram.desktop)"
        "size 60% 70%, class:(org.telegram.desktop)"
        "center, class:(org.telegram.desktop)"

        "float, class:(org.gnome.Nautilus)"
        "size 50% 60%, class:(org.gnome.Nautilus)"

        "float, initialTitle:(Godot), class:(?!org.godotengine.Editor)"
        "tile, class:(org.godotengine.Editor)"
        "maximize, class:(org.godotengine.Editor)"
        "size 1600 900, class:(Space Roguelite)"
        "size 720 1280, class:(Project F)"
        "move 60% 5%, class:(Project F)"
      ];

      animation = [
        "global, 1, 3, default"
        "workspaces, 1, 5, default, slidefade"
        "specialWorkspace, 1, 3, default, slidefadevert"
      ];
    };
  };
}
