{ pkgs, ... }:

{
  imports = [
    ./home/home-manager
    ./home/cli
  ];

  home.packages = with pkgs; [
    simple-mtpfs
  ];
}
