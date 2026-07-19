{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.sops;
in
with lib;
{
  options.programs.sops = {
    enable = mkEnableOption (mdDoc "sops, oauth credential manager");

    package = mkPackageOption pkgs "sops" { };

    age.package = mkPackageOption pkgs "age" { };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
      cfg.age.package
    ];

    home.sessionVariables = {
      SOPS_AGE_KEY_FILE = "~/.secret/age.txt";
    };
  };
}
