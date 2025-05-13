{ pkgs, ... }:

{
  imports = [
    ./neovim
    ./nushell
    ./git
    ./zellij
    ./eza
    ./yazi
    ./taskwarrior
    ./timewarrior
    ./aichat
    ./zoxide
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    just
    bat
    tgt
    watchexec
  ];
}
