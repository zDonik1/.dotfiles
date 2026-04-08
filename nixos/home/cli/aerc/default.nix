{
  pkgs,
  lib,
  config,
  ...
}:
let
  getKeepassEntry = pkgs.callPackage ../../common/get-keepass-entry.nix { };
  mbsyncExe = "${lib.getExe config.programs.mbsync.package}";

  toolConfig = {
    aerc.enable = config.programs.aerc.enable;

    mbsync = {
      enable = config.programs.mbsync.enable;
      create = "both";
      expunge = "both";
    };
  };

  realName = "Doniyor Tokhirov";
  signature = {
    showSignature = "append";
    text = ''
      With best regards,
      Doniyor T.
    '';
  };
in
{
  accounts.email.accounts = {
    main = {
      primary = true;
      inherit realName signature;
      address = "doniyor@tokhirov.uz";

      userName = "doniyor@tokhirov.uz";
      passwordCommand = "${lib.getExe getKeepassEntry} password main-email";

      imap.host = "mail.tokhirov.uz";
      smtp.host = "mail.tokhirov.uz";
    }
    // toolConfig;

    gmail = {
      inherit realName signature;
      address = "tokhirovdoniyor@gmail.com";

      userName = "tokhirovdoniyor@gmail.com";
      passwordCommand = "${lib.getExe getKeepassEntry} password gmail-email";

      flavor = "gmail.com";
    }
    // toolConfig;
  };

  programs = {
    mbsync.enable = true;

    aerc = {
      enable = true;

      extraConfig = {
        general = {
          unsafe-accounts-conf = true;
        };

        ui = {
          sort = "-r date";
          auto-mark-read-split = true;
          threading-enabled = true;
          thread-prefix-tip = "";
          thread-prefix-indent = "";
          thread-prefix-stem = "│";
          thread-prefix-limb = "─";
          thread-prefix-folded = "+";
          thread-prefix-unfolded = "";
          thread-prefix-first-child = "┬";
          thread-prefix-has-siblings = "├";
          thread-prefix-orphan = "┌";
          thread-prefix-dummy = "┬";
          thread-prefix-lone = " ";
          thread-prefix-last-sibling = "╰";
        };

        viewer.pager =
          let
            moor = config.programs.moor;
          in
          lib.mkIf moor.enable "${lib.getExe moor.package}";

        compose.empty-subject-warning = true;

        filters = ''
          text/plain=colorize
          text/html=html | colorize
          text/calendar=calendar
          text/*=bat -fP --file-name=\"$AERC_FILENAME\" --style=plain
          .headers=colorize
          message/delivery-status=colorize
        '';

        hooks =
          let
            syncAccountCmd = ''sh -c "${mbsyncExe} $AERC_ACCOUNT > /dev/null 2>&1 &"'';
          in
          {
            mail-received = lib.mkIf pkgs.stdenv.isDarwin ''
              osascript -e "display notification \"$AERC_SUBJECT\" with title \"$AERC_ACCOUNT/$AERC_FOLDER\" subtitle \"New mail from $AERC_FROM_NAME\""
            '';
            mail-deleted = syncAccountCmd;
            mail-added = syncAccountCmd;
            mail-sent = syncAccountCmd;
            flag-changed = syncAccountCmd;
          };
      };

      extraBinds = builtins.readFile ./binds.conf;
    };
  };

  launchd.agents.mbsync =
    let
      homeDir = config.home.homeDirectory;
    in
    {
      enable = true;
      config = {
        ProgramArguments = [
          "${lib.getExe config.programs.mbsync.package}"
          "--all"
        ];
        StartInterval = 300;
        StandardOutPath = "${homeDir}/.local/share/mbsync-agent/out.log";
        StandardErrorPath = "${homeDir}/.local/share/mbsync-agent/error.log";
      };
    };
}
