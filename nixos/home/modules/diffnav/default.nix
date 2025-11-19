{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.diffnav;
in
with lib;
{
  imports = [ ../delta ];

  options.programs.diffnav = {
    enable = mkEnableOption "diffnav, a git diff pager based on delta but with a file tree";

    package = mkOption {
      type = types.package;
      default = pkgs.diffnav;
      description = "The diffnav package to use";
    };

    enableJujutsuIntegration = mkEnableOption "Jujutsu integration for diffnav";
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs = {
      delta.enable = true;

      jujutsu.settings = mkIf cfg.enableJujutsuIntegration {
        "--scope" = [
          {
            "--when".commands = [ "diff" ];
            ui.pager = "diffnav";
          }
        ];
      };
    };
  };
}
