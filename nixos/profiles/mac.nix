{
  home =
    { pkgs, ... }:
    {
      imports = [
        ../home/home-manager
        ../home/cli
        ../home/cli/aider
        ../home/cli/kubetui
        ../home/cli/borgmatic
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
      ];

      services.syncthing.enable = true;
      services.ollama.enable = true;

      fonts.fontconfig.enable = true;
    };
}
