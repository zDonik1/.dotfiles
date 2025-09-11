{ pkgs, ... }:

pkgs.writeShellScriptBin "get-keepass-entry" ''
  cat ~/keepass/master \
    | ${pkgs.keepassxc}/bin/keepassxc-cli show -sq -a password ~/keepass/Passwords.kdbx $1
''
