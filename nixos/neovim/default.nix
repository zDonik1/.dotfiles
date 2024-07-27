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

    # lua
    lua-language-server
    stylua

    # csharp
    csharp-ls

    # nix
    nil
    nixd
    nixfmt-rfc-style

    # python
    ruff
    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        python-lsp-server
        debugpy
      ]
    ))

    # cpp
    clang-tools_18
    lldb_18
    cmake-language-server
    cmake-format
  ];

  home.file = {
    ".config/clangd/config.yaml".text = ''
      CompileFlags:
        Add: [-std=c++20]
    '';
  };
}
