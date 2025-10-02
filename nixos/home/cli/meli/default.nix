{ pkgs, lib, ... }:
let
  getKeepassEntry = pkgs.callPackage ../../common/get-keepass-entry.nix { };
  mocha = import ../../common/catppuccin-mocha.nix;

  oauth2 = pkgs.writeShellScriptBin "oauth2" ''
    ${lib.getExe pkgs.python3} ${./oauth2.py} "$@"
  '';
in
{
  home.packages = with pkgs; [
    w3m
  ];

  programs.meli = {
    enable = true;
    package = pkgs.writeScriptBin "noop" "";
    settings = {
      listing = {
        index_style = "Compact";
        sidebar_mailbox_tree_has_sibling = " ┃";
        sidebar_mailbox_tree_no_sibling = "  ";
        sidebar_mailbox_tree_has_sibling_leaf = " ┣━";
        sidebar_mailbox_tree_no_sibling_leaf = " ┗━";
      };
      composing.use_signature = true;

      accounts = {
        _main = {
          root_mailbox = "INBOX";
          format = "imap";
          server_hostname = "mail.tokhirov.uz";
          server_username = "doniyor@tokhirov.uz";
          server_password_command = "${lib.getExe getKeepassEntry} password main-email";
          server_port = "993";
          identity = "doniyor@tokhirov.uz";
          display_name = "Doniyor Tokhirov";

          send_mail = {
            hostname = "mail.tokhirov.uz";
            port = 587;
            auth = {
              type = "auto";
              username = "doniyor@tokhirov.uz";
              password.type = "command_eval";
              password.value = "${lib.getExe getKeepassEntry} password main-email";
            };
          };
        };

        gmail =
          let
            tokenCommand = lib.concatStrings [
              "TOKEN=$("
              "${lib.getExe oauth2} --quiet "
              "--user=tokhirovdoniyor@gmail.com "
              "--client_id=$(${lib.getExe getKeepassEntry} username meli-oauth-client) "
              "--client_secret=$(${lib.getExe getKeepassEntry} password meli-oauth-client) "
              "--refresh_token=$(${lib.getExe getKeepassEntry} password meli-oauth-refresh-token)"
              ") "
              "&& ${lib.getExe oauth2} --user=tokhirovdoniyor@gmail.com --generate_oauth2_string --quiet --access_token=$TOKEN"
            ];
          in
          {
            root_mailbox = "[Gmail]";
            format = "imap";
            server_hostname = "imap.gmail.com";
            server_username = "tokhirovdoniyor@gmail.com";
            use_oauth2 = true;
            server_password_command = tokenCommand;
            server_port = "993";
            identity = "tokhirovdoniyor@gmail.com";
            display_name = "Doniyor Tokhirov";
            composing.store_sent_mail = false;

            send_mail = {
              hostname = "smtp.gmail.com";
              port = 587;
              security.type = "STARTTLS";
              auth = {
                type = "xoauth2";
                token_command = tokenCommand;
                require_auth = true;
              };
            };
          };
      };

      shortcuts = {
        general = {
          scroll_left = "C-h";
          scroll_right = "C-l";
          next_page = "d";
          prev_page = "u";
          home_page = "g";
          end_page = "G";
        };

        listing = {
          next_page = "d";
          prev_page = "u";
          focus_left = "h";
          focus_right = "l";
          next_account = "L";
          prev_account = "H";

          commands = [
            {
              command = [ "set unseen" ];
              shortcut = "N";
            }
            {
              command = [ "flag set flagged" ];
              shortcut = "f";
            }
            {
              command = [ "flag unset flagged" ];
              shortcut = "F";
            }
          ];
        };

        thread-view = {
          next_page = "d";
          prev_page = "u";
          collapse_subtree = "s";
        };

        pager = {
          page_down = "d";
          page_up = "u";
        };

        envelope-view = {
          toggle_expand_headers = "s";
          change_charset = "C-c";
        };
      };

      terminal = {
        theme = "catpputccin-mocha";
        file_picker_command = "yazi --chooser-file /dev/stdout | tr '\n' '\0'";
        progress_spinner_sequence = 29;

        themes.catpputccin-mocha = {
          "error_message".fg = mocha.red;
          "text.unfocused".fg = mocha.subtext-0;
          "text.error".fg = mocha.red;
          "text.highlight".fg = mocha.blue;
          "status.bar".fg = mocha.teal;
          "status.bar".bg = mocha.surface-0;
          "status.command_bar".fg = mocha.crust;
          "status.command_bar".bg = mocha.peach;
          "status.history".fg = mocha.mantle;
          "status.history".bg = mocha.yellow;
          "status.history.hints".fg = mocha.mantle;
          "status.notification".fg = mocha.pink;
          "tab.unfocused".fg = mocha.subtext-1;
          "tab.unfocused".bg = mocha.surface-0;
          "tab.bar".bg = mocha.surface-0;
          "mail.sidebar".bg = mocha.mantle;
          "mail.sidebar_unread_count".fg = mocha.mauve;
          "mail.sidebar_index".fg = mocha.surface-1;
          "mail.sidebar_highlighted".fg = mocha.mantle;
          "mail.sidebar_highlighted".bg = mocha.blue;
          "mail.sidebar_highlighted_unread_count".fg = mocha.base;
          "mail.sidebar_highlighted_account".fg = "theme_default";
          "mail.sidebar_highlighted_account".bg = mocha.surface-0;
          "mail.listing.compact.even".bg = "theme_default";
          "mail.listing.compact.even_unseen".fg = mocha.lavender;
          "mail.listing.compact.even_unseen".bg = "theme_default";
          "mail.listing.compact.even_unseen".attrs = "Bold";
          "mail.listing.compact.odd_unseen".fg = "mail.listing.compact.even_unseen";
          "mail.listing.compact.odd_unseen".bg = "mail.listing.compact.even_unseen";
          "mail.listing.compact.odd_unseen".attrs = "mail.listing.compact.even_unseen";
          "mail.listing.compact.even_selected".fg = mocha.mantle;
          "mail.listing.compact.even_selected".bg = mocha.yellow;
          "mail.listing.compact.odd_selected".fg = "mail.listing.compact.even_selected";
          "mail.listing.compact.odd_selected".bg = "mail.listing.compact.even_selected";
          "mail.listing.compact.even_highlighted".fg = mocha.crust;
          "mail.listing.compact.even_highlighted".bg = mocha.blue;
          "mail.listing.compact.odd_highlighted".fg = "mail.listing.compact.even_highlighted";
          "mail.listing.compact.odd_highlighted".bg = "mail.listing.compact.even_highlighted";
          "mail.listing.compact.even_highlighted_selected".fg = "mail.listing.compact.even_highlighted";
          "mail.listing.compact.even_highlighted_selected".bg = "mail.listing.compact.even_highlighted";
          "mail.listing.compact.odd_highlighted_selected".fg =
            "mail.listing.compact.even_highlighted_selected";
          "mail.listing.compact.odd_highlighted_selected".bg =
            "mail.listing.compact.even_highlighted_selected";
          "mail.listing.tag_default".fg = mocha.sky;
          "mail.listing.tag_default".bg = mocha.surface-0;
          "mail.view.headers".fg = mocha.flamingo;
          "mail.view.headers".bg = "mail.view.headers_area";
          "mail.view.headers_names".fg = mocha.blue;
          "mail.view.headers_area".bg = "theme_default";
          "pager.highlight_search".bg = mocha.surface-1;
          "pager.highlight_search_current".bg = mocha.red;
        };
      };
    };
  };

  xdg.configFile."meli/signature".text = ''
    With best regards,
    Doniyor T.
  '';
}
