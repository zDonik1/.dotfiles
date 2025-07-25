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
    };
}
