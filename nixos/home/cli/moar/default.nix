{ pkgs, ... }:

{
  home.packages = [ pkgs.moar ];

  home.sessionVariables = {
    PAGER = "moar";
    MOAR = "-style catppuccin-mocha -statusbar bold -no-clear-on-exit -quit-if-one-screen";
  };
}
