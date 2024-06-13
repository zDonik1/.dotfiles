@help:
    just -lu --list-heading=$'{{ file_name(justfile()) }} commands:\n'

# strict check journal
bld:
    git add .
    sudo nixos-rebuild switch --flake ./nixos#wsl
