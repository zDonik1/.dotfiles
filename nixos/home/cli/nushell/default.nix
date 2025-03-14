{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [ polars ];
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;

    shellAliases = {
      ts = "task";
    };
  };

  home.packages = with pkgs; [
    starship
  ];

  xdg.configFile = {
    "nushell/completions".source = ./completions;
    "nushell/starship".source = ./starship;
    "nushell/themes".source = ./themes;
    "nushell/zoxide".source = ./zoxide;
  };
}
