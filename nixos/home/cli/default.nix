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
    ./direnv
    ./zoxide
    ./gdu
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    just
    bat
    tgt
    watchexec
    htop
  ];
}
