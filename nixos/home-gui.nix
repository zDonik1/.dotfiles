{ pkgs, ... }:
{
  imports = [
    ./home.nix
    ./gui/hyprland
    ./gui/mako
    ./gui/keepmenu
  ];

  home.packages = with pkgs; [
    telegram-desktop
    keepassxc
    loupe
    nautilus
    vlc
    libreoffice-qt6-fresh
    vistafonts
    obsidian
    gimp
    inkscape
  ];

  programs = {
    obs-studio.enable = true;

    thunderbird = {
      enable = true;
      profiles.zdonik.isDefault = true;
    };
  };

  services = {
    syncthing.enable = true;
  };

  fonts.fontconfig.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  gtk = {
    enable = true;
    # font.name = "";
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };
}
