{ catppuccin, ... }:

{
  catppuccin.sources.delta = catppuccin.delta.overrideAttrs {
    src = ./catppuccin;
  };

  programs.git.delta = {
    enable = true;
    options = {
      line-numbers = true;
      side-by-side = true;
    };
  };
}
