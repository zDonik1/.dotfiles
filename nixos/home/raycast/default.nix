{
  pkgs,
  config,
  lib,
  ...
}:

lib.mkIf config.programs.kitty.enable {
  xdg.configFile = {
    "raycast/custom/new_kitty.sh" = {
      executable = true;
      source = pkgs.replaceVars ./new_kitty.sh {
        kitty_path = "${config.programs.kitty.package}";
      };
    };
  };
}
