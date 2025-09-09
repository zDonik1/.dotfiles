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
        helmfile
        claude-code
      ];

      home.sessionPath = [ "$HOME/.local/bin" ];

      services.syncthing.enable = true;
      services.ollama.enable = false;

      fonts.fontconfig.enable = true;
    };

  system =
    { nix-rosetta-builder, ... }:
    {
      imports = [
        nix-rosetta-builder.darwinModules.default
        ../system/devenv
      ];

      nix.linux-builder.enable = true;
      nix-rosetta-builder.onDemand = true;

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
