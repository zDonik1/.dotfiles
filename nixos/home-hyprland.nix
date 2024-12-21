{ pkgs, ... }:
{
  imports = [
    ./home-gui.nix
    ./gui/hyprland
    ./gui/mako
    ./gui/keepmenu
  ];

  home.packages = with pkgs; [
    loupe
    nautilus
    libreoffice-qt6-fresh
    vistafonts
  ];
}
