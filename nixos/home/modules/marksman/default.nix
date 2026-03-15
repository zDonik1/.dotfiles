{
  pkgs,
  lib,
  config,
  ...
}:
let
  name = "marksman";
  cfg = config.programs.${name};
  dir = if pkgs.stdenv.isDarwin then "Library/Application Support" else config.xdg.configHome;

  toml = pkgs.formats.toml { };
in
with lib;
{
  options.programs.${name} = {
    enable = mkEnableOption (mdDoc "${name}, LSP for markdown");

    package = mkPackageOption pkgs name { };
  };

  config = mkIf cfg.enable {
    home = {
      packages = [ pkgs.${name} ];

      file."${dir}/marksman/config.toml".source = toml.generate "marksman-config" {
        completion.wiki.style = "file-stem";
      };
    };
  };
}
