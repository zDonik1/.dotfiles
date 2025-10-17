{ pkgs, ... }:

{
  home.packages = with pkgs; [ nchat ];

  xdg.configFile = {
    "nchat/app.conf".source = ./app.conf;
    "nchat/color.conf".source = ./color.conf;
    "nchat/usercolor.conf".source = ./usercolor.conf;
    "nchat/key.conf".source = ./key.conf;
    "nchat/ui.conf".source = ./ui.conf;
  };
}
