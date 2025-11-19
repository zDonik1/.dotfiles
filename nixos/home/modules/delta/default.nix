{
  lib,
  config,
  catppuccin,
  ...
}:
let
  cfg = config.programs.delta;
in
with lib;
{
  catppuccin.sources.delta = catppuccin.delta.overrideAttrs {
    src = ./catppuccin;
  };

  programs.delta = {
    options = {
      features = mkForce "side-by-side catppuccin-mocha";
      line-numbers = true;
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
            "| ${getExe config.programs.delta.package} --features catppuccin-mocha --width=$width"
          ])
        ];
      };
    };

    lazyjj.diff-tool = "delta-no-sbs";
  };
}
