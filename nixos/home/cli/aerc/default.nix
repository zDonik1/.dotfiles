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
      Best regards,
      Doniyor T.
    '';
  };
in
{
  accounts.email.accounts = {
    main = rec {
      primary = true;
      inherit realName signature;
      address = "doniyor@tokhirov.uz";

      userName = address;
      passwordCommand = "${lib.getExe getKeepassEntry} password main-email";

      imap.host = "mail.tokhirov.uz";
      smtp.host = "mail.tokhirov.uz";
    }
    // toolConfig;

    gmail = rec {
      inherit realName signature;
      address = "tokhirovdoniyor@gmail.com";

      userName = address;
      passwordCommand = "${lib.getExe getKeepassEntry} password gmail-email";

      flavor = "gmail.com";
    }
    // toolConfig;

    toptal = lib.recursiveUpdate rec {
      inherit realName signature;
      address = "doniyor.tokhirov@toptal.com";

      userName = address;
      passwordCommand = "${lib.getExe config.programs.oama.package} access ${address}";

      flavor = "gmail.com";

      aerc = {
        smtpAuth = "xoauth2";
      };

      mbsync.extraConfig.account.AuthMechs = "XOAUTH2";
    } toolConfig;
  };

  programs = {
    mbsync = {
      enable = true;
      package = pkgs.isync.override { withCyrusSaslXoauth2 = true; };
    };

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
