nixpkgs-latest: [
  (final: prev: {
    goose-cli = prev.goose-cli.overrideAttrs {
      doCheck = false;
    };
  })
]
