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
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    zoxide
    just
    bat
    tgt
    watchexec
  ];
}
