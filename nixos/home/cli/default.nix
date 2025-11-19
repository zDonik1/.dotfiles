{ pkgs, ... }:

{
  imports = [
    ../modules
    ./neovim
    ./starship
    ./nushell
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
    ./vdirsyncer
    ./cargo
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    moar.enable = true;
    delta.enable = true;
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
