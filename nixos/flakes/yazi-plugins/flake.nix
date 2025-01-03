{
  description = "Library and tooling that supports remote filesystem and process operations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    yazi-plugins-src = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      yazi-plugins-src,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { system = system; };

        pluginNames = builtins.attrNames (
          pkgs.lib.attrsets.filterAttrs (name: value: value == "directory") (
            builtins.readDir yazi-plugins-src
          )
        );

        mkYaziPluginDrv =
          name:
          pkgs.stdenvNoCC.mkDerivation {
            inherit name;
            src = yazi-plugins-src + "/${name}";

            installPhase = ''
              runHook preInstall
              cp -r $src $out
              runHook postInstall
            '';
          };
      in
      {
        packages = builtins.listToAttrs (
          builtins.map (name: {
            inherit name;
            value = mkYaziPluginDrv name;
          }) pluginNames
        );
      }
    );
}
