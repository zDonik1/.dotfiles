{
  home =
    { pkgs, ... }:
    {
      imports = [
        ../home/home-manager
        ../home/cli
        ../home/theme/adwaita
        ../home/wm/awesome
        ../home/firefox
        ../home/kitty
      ];

      home.packages = with pkgs; [
        telegram-desktop
        keepassxc
        vlc
        obsidian
        mpv
        loupe
        nautilus
        kdePackages.kdenlive
        libqalculate
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
        ../system/awesome
        ../system/connman
        ../system/expressvpn
        ../system/game
      ];

      # needed for ../home/theme/adwaita
      programs.dconf.enable = true;

      services.autorandr.enable = true;
    };
}
