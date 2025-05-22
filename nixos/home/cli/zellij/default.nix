{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    zellij
  ];

  xdg.configFile =
    let
      layouts = import ./layouts.nix {
        inherit config;
        inherit (pkgs) zjstatus;
      };
    in
    {
      "zellij/config.kdl".source = ./config.kdl;
      "zellij/layouts/default.kdl".text = layouts.default;
      "zellij/layouts/default.swap.kdl".text = layouts.defaultSwap;
      "zellij/layouts/journal.kdl".text = layouts.journal;
      "zellij/layouts/journal.swap.kdl".text = layouts.defaultSwap;
    };
}
