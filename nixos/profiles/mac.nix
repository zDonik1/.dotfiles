{
  home =
    { pkgs, ... }:
    {
      imports = [
        ../home/home-manager
        ../home/cli
        ../home/firefox
        ../home/kitty
        ../home/ghostty
        ../home/raycast
        ../home/wm/aerospace
      ];

      home.packages = with pkgs; [
        telegram-desktop
        obsidian
        libqalculate
        kubectl
        kubetui
        aider-chat
      ];

      services.syncthing.enable = true;
      services.ollama.enable = true;

      fonts.fontconfig.enable = true;
    };
}
