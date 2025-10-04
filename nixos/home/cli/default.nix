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

  programs = {
    bat.enable = true;
    btop.enable = true;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    just
    watchexec
    htop
    wget
    exiftool
  ];
}
