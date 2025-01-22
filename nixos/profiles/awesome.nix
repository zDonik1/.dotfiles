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
        borgbackup
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
        ../system/wm/awesome
        ../system/connman
        ../system/expressvpn
        ../system/nfs
        ../system/game
        ../system/vm/virtualbox
      ];

      # needed for ../home/theme/adwaita
      programs.dconf.enable = true;

      services.autorandr.enable = true;
    };
}
