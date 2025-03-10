{
  home =
    { pkgs, ... }:
    {
      imports = [
        ../home/home-manager
        ../home/cli
        ../home/firefox
        ../home/kitty
        ../home/raycast
      ];

      home.packages = with pkgs; [
        telegram-desktop
        obsidian
        libqalculate
        rclone
      ];

      services.syncthing.enable = true;

      fonts.fontconfig.enable = true;
    };
}
