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
      "zellij/layouts/time.kdl".text = layouts.time;
      "zellij/layouts/time.swap.kdl".text = layouts.defaultSwap;
      "zellij/layouts/ledger.kdl".text = layouts.ledger;
      "zellij/layouts/ledger.swap.kdl".text = layouts.defaultSwap;
    };
}
