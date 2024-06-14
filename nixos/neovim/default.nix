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
    python312Packages.python-lsp-server # python
    ruff

    # formatters
    stylua
    nixfmt-rfc-style
  ];
}
