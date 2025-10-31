{ lib, catppuccin, ... }:

{
  catppuccin.sources.delta = catppuccin.delta.overrideAttrs {
    src = ./catppuccin;
  };

  programs.delta = {
    enable = true;
    options = {
      features = lib.mkForce "catppuccin-mocha";
      line-numbers = true;

      side-by-side = {
        side-by-side = true;
      };
    };
    enableGitIntegration = true;
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
