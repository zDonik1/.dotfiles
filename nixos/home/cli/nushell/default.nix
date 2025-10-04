{ pkgs, catppuccin, ... }:

{
  home.shell.enableNushellIntegration = true;

  catppuccin.sources.nushell = catppuccin.nushell.overrideAttrs {
    src = ./catppuccin;
  };

  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [ polars ];
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;

    shellAliases = {
      jt = "just devtest";
    };

    extraConfig = ''
      source ${./completions/cargo-completions.nu}
      source ${./completions/git-completions.nu}
      source ${./completions/gh-completions.nu}
      source ${./completions/rg-completions.nu}
    '';
  };

  xdg.configFile = {
    "nushell/completions".source = ./completions;
  };
}
