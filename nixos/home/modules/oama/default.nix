{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.oama;

  getKeepassEntry = pkgs.callPackage ../../common/get-keepass-entry.nix { };
in
with lib;
{
  options.programs.oama = {
    enable = mkEnableOption (mdDoc "oama, oauth credential manager");

    package = mkPackageOption pkgs "oama" { };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile = {
      "oama/config.yaml".text = lib.generators.toYAML { } {
        encryption.tag = "KEYRING";

        services.google = {
          client_id_cmd = "${lib.getExe getKeepassEntry} password oama-client-id";
          client_secret_cmd = "${lib.getExe getKeepassEntry} password oama-client-secret";
        };
      };
    };
  };
}
