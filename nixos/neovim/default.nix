{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim

    # compiling fzf-native
    nushell
    cmake
    gnumake
    gcc

    # fugitive
    git

    # lsps
    lua-language-server
    csharp-ls
    nil # nix
    nixd
    ruff

    # formatters
    stylua
    nixfmt-rfc-style

    # python
    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        python-lsp-server
        debugpy
      ]
    ))
  ];
}
