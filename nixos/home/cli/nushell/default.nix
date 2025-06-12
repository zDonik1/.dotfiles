{ pkgs, ... }:

{
  home.shell.enableNushellIntegration = true;

  programs.starship.enable = true;

  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [ polars ];
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;

    shellAliases = {
      jt = "just devtest";
    };
  };

  xdg.configFile = {
    "nushell/completions".source = ./completions;
    "nushell/themes".source = ./themes;
    "nushell/taskwarrior.nu".source = ./taskwarrior.nu;
  };
}
