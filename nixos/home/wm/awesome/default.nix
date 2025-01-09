{ pkgs, ... }:

{
  xsession.windowManager.awesome.enable = true;

  home.packages = with pkgs; [
    maim
    xclip
    xorg.xbacklight
  ];
}
