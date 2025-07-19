{ pkgs, config, ... }:
let
  homeDir = config.home.homeDirectory;
  backupsDir = "${homeDir}/diskstation/backups";

  getKeepassEntry = pkgs.writeShellScriptBin "get-keepass-entry" ''
    cat ~/keepass/master \
      | ${pkgs.keepassxc}/bin/keepassxc-cli show -sq -a password ~/keepass/Passwords.kdbx $1
  '';

  retention = {
    keepDaily = 5;
    keepWeekly = 3;
    keepMonthly = 2;
    keepYearly = 1;
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
        inherit retention;
      };
      ledger = {
        location = {
          sourceDirectories = [ "${homeDir}/ledger" ];
          repositories = [ "${backupsDir}/ledger" ];
        };
        storage.encryptionPasscommand = "${getKeepassEntry}/bin/get-keepass-entry ledger";
        inherit retention;
      };
      timetask = {
        location = {
          sourceDirectories = [
            "${homeDir}/.local/share/task"
            "${homeDir}/.local/share/timewarrior"
          ];
          repositories = [ "${backupsDir}/timetask" ];
        };
        storage.encryptionPasscommand = "${getKeepassEntry}/bin/get-keepass-entry timetask";
        inherit retention;
      };
    };
  };

  launchd.agents."borgmatic" = {
    enable = true;
    config = {
      ProgramArguments = [ "${config.programs.borgmatic.package}/bin/borgmatic" ];
      StartCalendarInterval = [
        {
          Hour = 0;
          Minute = 0;
        }
      ];
    };
  };
}
