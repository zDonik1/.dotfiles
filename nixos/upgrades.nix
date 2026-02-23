[
  (final: prev: {
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
  })
]
