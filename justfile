@help:
    just -l --list-heading=$'{{ file_name(justfile()) }} commands:\n'

# build the nixos system for tp-p53
bld:
    sudo nixos-rebuild switch --flake ./nixos#tp-p53

# build the nixos system for wsl
wsl-bld:
    sudo nixos-rebuild switch --flake ./nixos#wsl

# build the nixos system for work wsl
wrk-bld:
    sudo nixos-rebuild switch --flake ./nixos#work-wsl
