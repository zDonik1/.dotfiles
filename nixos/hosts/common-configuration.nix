{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      neovim
      git
      ripgrep
      fd
      fzf
      zoxide
      nushell
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  nixpkgs.config.allowUnfree = true;
}
