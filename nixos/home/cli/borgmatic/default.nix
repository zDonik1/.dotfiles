{ pkgs, config, ... }:
let
  homeDir = config.home.homeDirectory;
  backupsDir = "${homeDir}/diskstation/backups";

  getKeepassEntry = pkgs.writeShellScriptBin "get-keepass-entry" ''
    cat ~/keepass/master \
      | ${pkgs.keepassxc}/bin/keepassxc-cli show -sq -a password ~/keepass/Passwords.kdbx $1
  '';
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
        retention = {
          keepDaily = 5;
          keepWeekly = 3;
          keepMonthly = 2;
          keepYearly = 1;
        };
        storage.encryptionPasscommand = "${getKeepassEntry}/bin/get-keepass-entry SecondBrain";
      };
      ledger = {
        location = {
          sourceDirectories = [ "${homeDir}/ledger" ];
          repositories = [ "${backupsDir}/ledger" ];
        };
        retention = {
          keepDaily = 5;
          keepWeekly = 3;
          keepMonthly = 2;
          keepYearly = 1;
        };
        storage.encryptionPasscommand = "${getKeepassEntry}/bin/get-keepass-entry ledger";
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
