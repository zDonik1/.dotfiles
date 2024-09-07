{ config, pkgs, ... }:
let
  hyprswitch-conf = "hypr/hyprswitch.conf";
  catppuccin-mocha-conf = "hypr/catppuccin-mocha.conf";
in
{
  imports = [
    ../hypridle
    ../hyprpaper
  ];

  home = {
    packages = with pkgs; [
      qt5.qtwayland
      qt6.qtwayland
      hyprswitch
      grimblast
      wl-clipboard
    ];
  };

  xdg.configFile = {
    "${hyprswitch-conf}".source = ./hyprswitch.conf;
    "${catppuccin-mocha-conf}".source = ./catppuccin-mocha.conf;
  };

  programs = {
    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11;
      };
      theme = "Catppuccin-Mocha";
      settings = {
        # couldn't select bold styles automatically
        bold_font = "family=\"JetBrainsMono Nerd Font\" style=\"Bold\"";
        italic_font = "auto";
        bold_italic_font = "family=\"JetBrainsMono Nerd Font\" style=\"Bold Italic\"";

        window_padding_width = "6 8";
      };
    };
    wofi.enable = true;
  };

  services = {
    udiskie.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      source = [
        (config.xdg.configHome + "/" + hyprswitch-conf)
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
      ];

      "cursor:no_hardware_cursors" = true;

      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "wofi --show drun";

      exec-once = [
        "systemctl --user start plasma-polkit-agent"
        "hypridle"
        "hyprpaper"
        "hyprswitch init &"

        "syncthing --no-browser &"

        "hyprctl dispatch workspace 1"
        "firefox"
        "sleep 2; $terminal"
        "[workspace magic silent] telegram-desktop"
        # "nm-applet &"
        # "waybar & hyprpaper"
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

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "$mantle";
      };

      misc = {
        force_default_wallpaper = 0;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Q, killactive,"
        "$mainMod, X, exit"
        "$mainMod, P, pin,"
        "$mainMod, K, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, F, fullscreen, 1"
        "$mainMod, C, centerwindow, 1"
        "$mainMod SHIFT, F, fullscreen, 0"

        "$mainMod, U, exec, grimblast --freeze copysave area"
        "$mainMod SHIFT, U, exec, grimblast copysave output"

        "$mainMod, T, exec, $terminal"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $menu"
        "$mainMod, L, exec, telegram-desktop"

        "$mainMod, space, cyclenext,"
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

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, F1, pass, ^(com\.obsproject\.Studio)$"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"

        "float, class:(thunderbird), title:^$"
        "float, class:(org.gnome.Loupe)"

        "float, class:(org.telegram.desktop)"
        "size 60% 70%, class:(org.telegram.desktop)"
        "center, class:(org.telegram.desktop)"

        "float, class:(org.gnome.Nautilus)"
        "size 50% 60%, class:(org.gnome.Nautilus)"
      ];

      animation = [
        "global, 1, 3, default"
        "workspaces, 1, 5, default, slidefade"
        "specialWorkspace, 1, 3, default, slidefadevert"
      ];
    };
  };
}
