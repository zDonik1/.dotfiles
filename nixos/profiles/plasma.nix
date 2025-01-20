{
  home =
    { pkgs, ... }:
    {
      imports = [
        ../home/home-manager
        ../home/cli
        ../home/firefox
        ../home/kitty
      ];

      home.packages = with pkgs; [
        telegram-desktop
        keepassxc
        vlc
        obsidian
        mpv
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
        ../system/wm/plasma
        ../system/connman
        ../system/expressvpn
        ../system/game
        ../system/vm/virtualbox
      ];

      # needed for ../home/theme/adwaita
      programs.dconf.enable = true;

      services.autorandr.enable = true;
    };
}
