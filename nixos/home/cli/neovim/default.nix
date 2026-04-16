{ pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
      neovim

      # tree-sitter
      tree-sitter
      (if stdenv.isDarwin then clang else gcc)

      # lua
      lua-language-server
      stylua

      # nix
      nil
      nixd
      nixfmt
      biome

      # yaml
      yaml-language-server
      prettierd

      # toml
      taplo

      # markdown
      markdown-oxide
    ]
    ++ lib.optionals (!pkgs.stdenv.isDarwin) [
      # csharp
      csharp-ls
    ];
}
