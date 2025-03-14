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
    nushell
    starship
  ];
}
