{
  home =
    { pkgs, ... }:
    {
      imports = [
        ../home/home-manager
        ../home/cli
        ../home/theme/adwaita
        ../home/hyprland
        ../home/mako
        ../home/keepmenu
        ../home/firefox
      ];

      home.packages = with pkgs; [
        telegram-desktop
        keepassxc
        vlc
        obsidian
        gimp
        inkscape
        mpv
        loupe
        nautilus
        libreoffice-qt6-fresh
        vistafonts
      ];

      programs = {
        obs-studio.enable = true;

        thunderbird = {
          enable = true;
          profiles.zdonik.isDefault = true;
        };
      };

      services.syncthing.enable = true;

      fonts.fontconfig.enable = true;
    };

  system =
    { ... }:
    {
      imports = [
        ../system/greetd
        ../system/connman
        ../system/expressvpn
      ];
    };
}
