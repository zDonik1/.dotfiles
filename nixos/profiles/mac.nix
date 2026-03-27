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
        ../home/wallpaper
      ];

      home.packages = with pkgs; [
        telegram-desktop
        obsidian
        libqalculate
        kubectl
        claude-code
      ];

      home.sessionPath = [
        "$HOME/.local/bin"
        "$HOME/.cache/.bun/bin"
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "/Applications/Zen.app/Contents/MacOS/zen";
      };

      programs.mpv.enable = true;

      services.syncthing.enable = true;
      services.ollama.enable = true;

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

      services.tailscale.enable = true;

      environment.systemPath = [ "/opt/homebrew/bin" ];

      homebrew = {
        enable = true;

        brews = [
          "docker"
          "docker-buildx"
          "docker-completion"
          "docker-compose"
        ];

        casks = [
          "anydesk"
          "cursorcerer"
          "discord"
          "expressvpn"
          "ghostty"
          "gimp"
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
