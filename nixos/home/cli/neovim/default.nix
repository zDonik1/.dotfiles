{ pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
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

      # nix
      nil
      nixd
      nixfmt-rfc-style
      biome

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

      # rust
      rustfmt
      rust-analyzer

      # go
      gopls

      # gdscript
      gdtoolkit_4

      # yaml
      yaml-language-server
      prettierd

      # toml
      taplo

    ]
    ++ lib.optionals (!pkgs.stdenv.isDarwin) [
      # csharp
      csharp-ls
    ];

  home.file = {
    ".config/clangd/config.yaml".text = ''
      CompileFlags:
        Add: [-std=c++20]
    '';
  };
}
