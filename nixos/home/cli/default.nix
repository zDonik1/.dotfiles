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
    ./tmux
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    moor.enable = true;
    k9s.enable = true;
    mise.enable = true;
    oama.enable = true;
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
