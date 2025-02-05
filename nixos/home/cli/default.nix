{ pkgs, ... }:

{
  imports = [
    ./neovim
    ./nushell
    ./git
    ./zellij
    ./eza
    ./yazi
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    zoxide
    just
    bat
  ];
}
