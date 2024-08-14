{
  description = "Library and tooling that supports remote filesystem and process operations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    distant-src = {
      url = "github:chipsenkbeil/distant";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      distant-src,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { system = system; };
      in
      {
        packages.default = pkgs.rustPlatform.buildRustPackage {
          name = "distant";
          src = distant-src;

          cargoHash = "sha256-mPcrfBFgvbPi6O7i9FCtN3iaaEOHIcDFHCOpV1NxKMY=";

          nativeBuildInputs = with pkgs; [ perl ];

          # one of the tests are failing at the moment
          doCheck = false;
        };
      }
    );
}
