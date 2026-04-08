{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.goose-cli;
in
with lib;
{
  options.programs.goose-cli = {
    enable = mkEnableOption "goose, general-purpose AI agent that runs on your machine";

    package = mkOption {
      type = types.package;
      default = pkgs.goose-cli;
      description = "The goose package to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
