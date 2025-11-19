{ lib, config, ... }:
let
  cfg = config.programs.delta;
in
with lib;
{
  catppuccin.delta.enable = false;

  programs.delta = {
    options = {
      features = "side-by-side";
      line-numbers = true;

      # Theming
      # we can't use features for themeing because otherwise they can get overriden by
      # "side-by-side" or "lline-numbers" features
      blame-palette = "#1e1e2e #181825 #11111b #313244 #45475a";
      commit-decoration-style = "#6c7086 bold box ul";
      dark = true;
      file-decoration-style = "#6c7086";
      file-style = "bold yellow ul";
      hunk-header-decoration-style = "#6c7086 box ul";
      hunk-header-file-style = "bold";
      hunk-header-line-number-style = "bold #a6adc8";
      hunk-header-style = "file line-number syntax";
      line-numbers-left-style = "#6c7086";
      line-numbers-minus-style = "bold #f38ba8";
      line-numbers-plus-style = "bold #a6e3a1";
      line-numbers-right-style = "#6c7086";
      line-numbers-zero-style = "#6c7086";
      # 25% red 75% base;
      minus-emph-style = "bold syntax #53394c";
      # 10% red 90% base;
      minus-style = "syntax #34293a";
      # 25% green 75% base;
      plus-emph-style = "bold syntax #404f4a";
      # 10% green 90% base;
      plus-style = "syntax #2c3239";
      map-styles = concatStringsSep ", " [
        "bold purple => syntax #494060"
        "bold blue => syntax #384361"
        "bold cyan => syntax #384d5d"
        "bold yellow => syntax #544f4e"
      ];
      # Should match the name of the bat theme;
      syntax-theme = "Catppuccin Mocha";
    };

    enableGitIntegration = true;
    enableJujutsuIntegration = true;
  };

  programs.jujutsu.settings = mkIf (cfg.enable && cfg.enableJujutsuIntegration) {
    merge-tools = {
      delta-no-sbs = {
        program = "sh";
        diff-args = [
          "-c"
          (concatStringsSep " " [
            "${getExe config.programs.git.package} diff --no-index $left $right"
            "| sed 's|a/$left/|a/|g;s|b/$right/|b/|g'"
            "| ${getExe config.programs.delta.package} --features \"\" --width=$width"
          ])
        ];
      };
    };

    lazyjj.diff-tool = "delta-no-sbs";
  };
}
