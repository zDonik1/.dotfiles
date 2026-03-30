nixpkgs-latest: [
  (
    final: prev:
    let
      pkgs-latest = import nixpkgs-latest {
        inherit (prev) system;
        config.allowUnfree = true;
      };
    in
    {
      gh-dash = prev.gh-dash.overrideAttrs rec {
        version = "4.23.1";
        src = prev.fetchFromGitHub {
          owner = "dlvhdr";
          repo = "gh-dash";
          rev = "v${version}";
          sha256 = "sha256-znY+Lv2iqpWh1pc73Fm0GTjU6yZIDC4CX0jw9bAR91Q=";
        };
        vendorHash = "sha256-4AbeoH0l7eIS7d0yyJxM7+woC7Q/FCh0BOJj3d1zyX4=";

        ldflags = [
          "-s"
          "-w"
          "-X github.com/dlvhdr/gh-dash/v4/cmd.Version=${version}"
        ];

        nativeCheckInputs = [ prev.writableTmpDirAsHomeHook ];
        nativeInstallCheckInputs = [ prev.versionCheckHook ];
        doInstallCheck = true;
      };

      jujutsu = prev.jujutsu.overrideAttrs rec {
        version = "0.35.0";
        src = prev.fetchFromGitHub {
          owner = "jj-vcs";
          repo = "jj";
          tag = "v${version}";
          hash = "sha256-YUrjP2tzABdy4eAV1hPmgYWU8ChcJ5B4IlmQUGm95ro=";
        };

        cargoDeps = prev.rustPlatform.fetchCargoVendor {
          inherit src;
          hash = "sha256-9VCAmtY029+CFNFcYLdA/VyT5CIvJnuA3iwPOKZpYV0=";
        };
      };

      neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs rec {
        version = "0.11.6";
        src = prev.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          tag = "v${version}";
          hash = "sha256-GdfCaKNe/qPaUV2NJPXY+ATnQNWnyFTFnkOYDyLhTNg=";
        };
      };

      zellij = pkgs-latest.zellij;
      claude-code = pkgs-latest.claude-code;
    }
  )
]
