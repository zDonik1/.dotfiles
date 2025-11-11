{
  lib,
  config,
  catppuccin,
  ...
}:

{
  catppuccin.sources.delta = catppuccin.delta.overrideAttrs {
    src = ./catppuccin;
  };

  programs.delta = {
    enable = true;
    options = {
      features = lib.mkForce "side-by-side catppuccin-mocha";
      line-numbers = true;

      side-by-side = {
        side-by-side = true;
      };
    };
    enableGitIntegration = true;
  };

  programs.jujutsu.settings = {
    ui = {
      diff-formatter = "delta-sbs";
    };

    merge-tools = {
      delta-sbs = {
        program = "sh";
        diff-args = [
          "-c"
          (lib.concatStringsSep " " [
            "${lib.getExe config.programs.git.package} diff --no-index $left $right"
            "| sed 's|a/$left/|a/|g;s|b/$right/|b/|g'"
            "| ${lib.getExe config.programs.delta.package} --width=$width"
          ])
        ];
      };

      delta = {
        program = "sh";
        diff-args = [
          "-c"
          (lib.concatStringsSep " " [
            "${lib.getExe config.programs.git.package} diff --no-index $left $right"
            "| sed 's|a/$left/|a/|g;s|b/$right/|b/|g'"
            "| ${lib.getExe config.programs.delta.package} --features catppuccin-mocha --width=$width"
          ])
        ];
      };
    };

    lazyjj.diff-tool = "delta";
  };
}
