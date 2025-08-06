{ pkgs, lib, ... }:

{
  home.packages = [ pkgs.moar ];

  home.sessionVariables.PAGER = lib.concatStrings [
    "moar -style catppuccin-mocha -statusbar bold "
    "-no-clear-on-exit -quit-if-one-screen"
  ];
}
