{ pkgs, ... }:

pkgs.writeShellScriptBin "get-keepass-entry" ''
  cat ~/keepass/master \
    | ${pkgs.keepassxc}/bin/keepassxc-cli show -sq -a $1 ~/keepass/Passwords.kdbx $2
''
