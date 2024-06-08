{ ... }:

{
  programs.broot = {
    enable = true;

    settings = {
      icon_theme = "nerdfont";
      syntax_theme = "MochaDark";
      imports = [ "skins/catppuccin-mocha.hjson" ];
    };
  };
}
