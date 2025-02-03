{
  home =
    { pkgs, ... }:
    {
      imports = [
        ../home/home-manager
        ../home/cli
        ../home/kitty
      ];

      home.packages = with pkgs; [
        telegram-desktop
        keepassxc
        obsidian
        libqalculate
      ];

      services.syncthing.enable = true;

      fonts.fontconfig.enable = true;
    };
}
