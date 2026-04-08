{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.moor;
in
with lib;
{
  options.programs.moor = {
    enable = mkEnableOption (mdDoc "moor, a pager designed to just do the right thing");

    package = mkPackageOption pkgs "moor" { };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.sessionVariables = {
      PAGER = "moor";
      MOOR = "-style catppuccin-mocha -statusbar bold -no-clear-on-exit -quit-if-one-screen";
    };
  };
}
