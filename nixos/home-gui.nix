{ pkgs, ... }:

{
  imports = [
    ./home.nix
    ./gui/firefox
  ];

  home.packages = with pkgs; [
    telegram-desktop
    keepassxc
    vlc
    obsidian
    gimp
    inkscape
    mpv
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
