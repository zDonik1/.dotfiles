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
    ./fzf
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    just
    watchexec
    htop
    wget
    exiftool
  ];
}
