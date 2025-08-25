{
  pkgs,
  lib,
  config,
  ...
}:
let
  homeDir = config.home.homeDirectory;
  backupsDir = "${homeDir}/diskstation/backups";

  getKeepassEntry = pkgs.writeShellScriptBin "get-keepass-entry" ''
    cat ~/keepass/master \
      | ${pkgs.keepassxc}/bin/keepassxc-cli show -sq -a password ~/keepass/Passwords.kdbx $1
  '';

  common = {
    retention = {
      keepDaily = 5;
      keepWeekly = 3;
      keepMonthly = 2;
      keepYearly = 1;
    };

    hooks.extraConfig = {
      healthchecks.ping_url = "https://hc.tokhirov.uz/ping/ca35e3c3-ab27-4446-b5d9-9dc17ed4f5bf";
    };
  };
in
{
  programs.borgmatic = {
    enable = true;
    backups = {
      second-brain = {
        location = {
          sourceDirectories = [ "${homeDir}/SecondBrain" ];
          repositories = [ "${backupsDir}/SecondBrain" ];
        };
        storage.encryptionPasscommand = "${getKeepassEntry}/bin/get-keepass-entry SecondBrain";
      }
      // common;

      ledger = {
        location = {
          sourceDirectories = [ "${homeDir}/ledger" ];
          repositories = [ "${backupsDir}/ledger" ];
        };
        storage.encryptionPasscommand = "${getKeepassEntry}/bin/get-keepass-entry ledger";
      }
      // common;

      timetask = {
        location = {
          sourceDirectories = [
            "${homeDir}/.local/share/task"
            "${homeDir}/.local/share/timewarrior"
          ];
          repositories = [ "${backupsDir}/timetask" ];
        };
        storage.encryptionPasscommand = "${getKeepassEntry}/bin/get-keepass-entry timetask";
      }
      // common;

      partition-event = {
        location = {
          sourceDirectories = [ "${homeDir}/partition-event" ];
          repositories = [ "${backupsDir}/partition-event" ];
        };
        storage.encryptionPasscommand = "${getKeepassEntry}/bin/get-keepass-entry partition-event";
      }
      // common;
    };
  };

  home.activation.createBorgmaticApp =
    with lib;
    let
      launcher = pkgs.writeScript "borgmatic" ''
        try
            do shell script "${getExe config.programs.borgmatic.package}"
        on error errorMessage number errorNumber
            display notification "Backup failed - check logs for details" with title "Borg Backup Error"
        end try
      '';
    in
    mkIf pkgs.stdenv.isDarwin (
      hm.dag.entryAfter [ "writeBoundary" ] ''
        $VERBOSE_ECHO 'Creating Borgmatic.app'
        pushd '${homeDir}/Applications'
        $DRY_RUN_CMD rm -rf $VERBOSE_ARG Borgmatic.app || true
        $DRY_RUN_CMD /usr/bin/osacompile -o Borgmatic.app ${launcher}
      ''
    );

  launchd.agents."borgmatic" = lib.mkIf pkgs.stdenv.isDarwin {
    enable = true;
    config = {
      ProgramArguments = [
        "open"
        "--background"
        "--hide"
        "${homeDir}/Applications/Borgmatic.app"
      ];
      StartCalendarInterval = [
        {
          Hour = 0;
          Minute = 0;
        }
      ];
      StandardOutPath = "${homeDir}/.local/share/borgmatic-agent/out.log";
      StandardErrorPath = "${homeDir}/.local/share/borgmatic-agent/error.log";
    };
  };
}
