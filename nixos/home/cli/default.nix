{ pkgs, ... }:

{
  imports = [
    ./neovim
    ./starship
    ./nushell
    ./delta
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
    ./moar
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    just
    bat
    watchexec
    htop
    wget
    exiftool
  ];
}
