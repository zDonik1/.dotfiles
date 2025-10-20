{ pkgs, ... }:

{
  imports = [
    ../modules
    ./neovim
    ./starship
    ./nushell
    ./delta
    ./vcs
    ./zellij
    ./eza
    ./yazi
    ./taskwarrior
    ./timewarrior
    ./aichat
    ./direnv
    ./zoxide
    ./gdu
    ./fzf
    ./aerc
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    moar.enable = true;
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
