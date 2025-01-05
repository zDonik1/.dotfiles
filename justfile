@help:
    just -l --list-heading=$'{{ file_name(justfile()) }} commands:\n'

# switch to the nixos system
switch config:
    sudo nixos-rebuild switch -p {{ config }} --flake ./nixos#{{ config }}
