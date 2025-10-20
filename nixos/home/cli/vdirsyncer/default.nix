{
  pkgs,
  lib,
  config,
  ...
}:
let
  getKeepassEntry = pkgs.callPackage ../../common/get-keepass-entry.nix { };
in
{
  accounts.calendar = {
    basePath = "Calendar";

    accounts.main = {
      primary = true;
      remote = {
        type = "caldav";
        url = "https://nc.mukhtarov.net/remote.php/dav";
        userName = "zDonik";
        passwordCommand = [
          "${lib.getExe getKeepassEntry}"
          "password"
          "nextcloud-zdonik"
        ];
      };

      vdirsyncer = {
        enable = true;
        collections = [
          "from a"
          "from b"
        ];
      };
    };
  };

  programs.vdirsyncer.enable = true;

  launchd.agents.vdirsyncer =
    let
      homeDir = config.home.homeDirectory;
    in
    {
      enable = true;
      config = {
        ProgramArguments = [
          "${lib.getExe config.programs.vdirsyncer.package}"
          "sync"
        ];
        StartInterval = 600;
        StandardErrorPath = "${homeDir}/.local/share/vdirsyncer-agent/error.log";
      };
    };
}
