@help:
    just -l --list-heading=$'{{ file_name(justfile()) }} commands:\n'

# switch to the nixos system
switch config:
    sudo nixos-rebuild switch -p {{ config }} --flake ./nixos#{{ config }}

# test the nixos system
test config:
    sudo nixos-rebuild test -p {{ config }} --flake ./nixos#{{ config }}

# add nixos system to boot menu
boot config:
    sudo nixos-rebuild boot -p {{ config }} --flake ./nixos#{{ config }}

# delete older generations
del-old config:
    nix profile wipe-history --profile /nix/var/nix/profiles/system-profiles/{{ config }} --older-than 1d

# switch to darwin system
switch-mac *ARGS:
    sudo darwin-rebuild switch --flake ./nixos {{ ARGS }}
