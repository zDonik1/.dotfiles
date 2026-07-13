{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.mise;
in
with lib;
{
  programs.mise = {
    enableNushellIntegration = false;
    globalConfig = {
      settings = {
        experimental = true;
      };
    };
  };

  programs.nushell.extraConfig = mkIf (cfg.package != null) ''
    use ${
      pkgs.runCommand "mise-nushell-config" { } ''
        mkdir -p $out
        ${getExe cfg.package} activate nu > $out/mise.nu
      ''
    }/mise.nu
  '';
}
