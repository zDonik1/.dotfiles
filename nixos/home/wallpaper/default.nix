{
  pkgs,
  lib,
  config,
  ...
}:
let
  start = {
    morning = 6;
    day = 12;
    evening = 18;
    night = 22;
  };

  switchWallpaper = pkgs.writeScriptBin "switch-wallpaper" ''
    #!/usr/bin/env bash

    HOUR=$(date +%H)
    WALLPAPER_DIR="$HOME/wallpapers"

    if [ $HOUR -ge ${builtins.toString start.morning} ] && [ $HOUR -lt ${builtins.toString start.day} ]; then
        WALLPAPER="$WALLPAPER_DIR/tropic_island_morning.jpg"
    elif [ $HOUR -ge ${builtins.toString start.day} ] && [ $HOUR -lt ${builtins.toString start.evening} ]; then
        WALLPAPER="$WALLPAPER_DIR/tropic_island_day.jpg"
    elif [ $HOUR -ge ${builtins.toString start.evening} ] && [ $HOUR -lt ${builtins.toString start.night} ]; then
        WALLPAPER="$WALLPAPER_DIR/tropic_island_evening.jpg"
    else
        WALLPAPER="$WALLPAPER_DIR/tropic_island_night.jpg"
    fi

    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$WALLPAPER\""
  '';
in
{
  launchd.agents.switch-wallpaper =
    let
      homeDir = config.home.homeDirectory;
    in
    {
      enable = true;
      config = {
        ProgramArguments = [ "${lib.getExe switchWallpaper}" ];
        StartCalendarInterval = lib.mapAttrsToList (name: value: {
          Hour = value;
          Minute = 0;
        }) start;
        StandardOutPath = "${homeDir}/.local/share/mbsync-agent/out.log";
        StandardErrorPath = "${homeDir}/.local/share/mbsync-agent/error.log";
      };
    };
}
