{ pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
      neovim

      # compiling fzf-native
      cmake
      (if stdenv.isDarwin then clang else gcc)

      # lua
      lua-language-server
      stylua

      # nix
      nil
      nixd
      nixfmt-rfc-style
      biome

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
