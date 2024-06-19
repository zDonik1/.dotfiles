@help:
    just -lu --list-heading=$'{{ file_name(justfile()) }} commands:\n'

# build the nixos system for wsl
bld:
    git add .
    sudo nixos-rebuild switch --flake ./nixos#wsl
