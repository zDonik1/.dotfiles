{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zellij
    zjstatus
  ];

  home.file = {
    ".config/zellij/config.kdl".source = ./config.kdl;
    ".config/zellij/layouts/default.kdl".source = pkgs.substituteAll {
      src = ./layouts/default.kdl;
      zjstatus_path = "${pkgs.zjstatus}/bin/zjstatus.wasm";
    };
    ".config/zellij/layouts/default.swap.kdl".source = ./layouts/default.swap.kdl;
  };
}
