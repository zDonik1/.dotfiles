{
  lib,
  fetchFromGitHub,
  rustPlatform,
  ...
}:

rustPlatform.buildRustPackage rec {
  pname = "ftdv";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "wtnqk";
    repo = "ftdv";
    tag = "v${version}";
    hash = "sha256-J1lWrfZeH/V1hckLGWDoeU6aKFoLimddzaTKMQ8sDs8=";
  };

  cargoHash = "sha256-ZFIlDwq0qmBfL/GL7fMetUWuUhq6ywDt060dyoSCFqA=";

  meta = {
    description = "ftdv (File Tree Diff Viewer) is a terminal-based diff viewer";
    homepage = "https://github.com/wtnqk/ftdv";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
}
