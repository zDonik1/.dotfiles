{ nix-rosetta-builder, ... }:

{
  imports = [
    nix-rosetta-builder.darwinModules.default
  ];

  nix.linux-builder.enable = true;
  nix-rosetta-builder.onDemand = true;
}
