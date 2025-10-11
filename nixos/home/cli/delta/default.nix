{ lib, catppuccin, ... }:

{
  catppuccin.sources.delta = catppuccin.delta.overrideAttrs {
    src = ./catppuccin;
  };

  programs.git = {
    delta = {
      enable = true;
      options = {
        features = lib.mkForce "catppuccin-mocha";
        line-numbers = true;
      };
    };

    extraConfig = {
      # define the side-by-side delta feature
      delta.side-by-side = {
        side-by-side = true;
      };
    };
  };

  programs.jujutsu.settings = {
    ui = {
      diff-formatter = ":git";
      pager = [
        "delta"
        "--features"
        "side-by-side catppuccin-mocha"
      ];
    };

    merge-tools = {
      delta = {
        diff-expected-exit-codes = [
          0
          1
        ];
      };
    };

    lazyjj.diff-tool = "delta";
  };
}
