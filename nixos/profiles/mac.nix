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
        helmfile
        claude-code
      ];

      home.sessionPath = [ "$HOME/.local/bin" ];

      programs.mpv.enable = true;

      services.syncthing.enable = true;
      services.ollama.enable = false;

      fonts.fontconfig.enable = true;

      catppuccin = {
        enable = true;
        accent = "blue";
      };
    };

  system =
    { ... }:
    {
      imports = [
        ../system/devenv
      ];

      homebrew = {
        enable = true;

        brews = [
          "docker"
          "docker-buildx"
          "docker-completion"
          "docker-compose"
          "helm"
        ];

        casks = [
          "anydesk"
          "cursorcerer"
          "discord"
          "expressvpn"
          "ghostty"
          "gimp"
          "jordanbaird-ice"
          "karabiner-elements"
          "keepassxc"
          "libreoffice"
          "localsend"
          "obs"
          "orbstack"
          "raycast"
          "rectangle"
          "scroll-reverser"
          "shottr"
          "stats"
          "thunderbird"
          "whatsapp"
          "zen"
        ];
      };
    };
}
