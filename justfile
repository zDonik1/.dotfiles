@help:
    just -l --list-heading=$'{{ file_name(justfile()) }} commands:\n'

# switch to the nixos system
switch config:
    sudo nixos-rebuild switch -p {{ config }} --flake ./nixos#{{ config }}

# test the nixos system
test config:
    sudo nixos-rebuild test -p {{ config }} --flake ./nixos#{{ config }}
