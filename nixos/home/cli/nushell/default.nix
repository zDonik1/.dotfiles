{ pkgs, ... }:

{
  home.shell.enableNushellIntegration = true;

  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [ polars ];
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;

    shellAliases = {
      jt = "just devtest";
    };
  };

  home.packages = with pkgs; [
    starship
  ];

  xdg.configFile = {
    "nushell/completions".source = ./completions;
    "nushell/themes".source = ./themes;
    "nushell/starship".source = ./starship;
    "nushell/taskwarrior.nu".source = ./taskwarrior.nu;
  };
}
