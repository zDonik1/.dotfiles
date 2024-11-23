{ pkgs, ... }:

{
  imports = [
    ./base.nix
  ];

  home.packages = with pkgs; [
    simple-mtpfs
  ];
}
