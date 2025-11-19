{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.ftdv;
in
with lib;
{
  options.programs.ftdv = {
    enable = mkEnableOption "ftdv, a terminal-based file tree diff viewer";

    jjIntegration = {
      enable = mkEnableOption "Jujutsu integration for ftdv";

      setDiffFormatter = mkOption {
        type = types.bool;
        default = false;
        description = "Set ftdv as the diff formatter in jj config";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ ftdv ];

    programs.jujutsu.settings = {
      ui.diff-formatter = "ftdv";

      merge-tools.ftdv = {
        program = "ftdv";
        diff-args = [ "$left $right" ];
      };
    };
  };
}
