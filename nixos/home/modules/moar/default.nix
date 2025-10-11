{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.moar;
in
with lib;
{
  options.programs.moar = {
    enable = mkEnableOption (mdDoc "moar, a pager designed to just do the right thing");

    package = mkPackageOption pkgs "moar" { };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.moar ];

    home.sessionVariables = {
      PAGER = "moar";
      MOAR = "-style catppuccin-mocha -statusbar bold -no-clear-on-exit -quit-if-one-screen";
    };
  };
}
