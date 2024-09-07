{ pkgs, ... }:
let
  # set the env vars since the default shell is nushell
  _ = pkgs.runCommand "set-env-vars" { } ''
    source $env.HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
  '';
  homeDir = "/home/zdonik";
in
{
  home = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "zdonik";
    homeDirectory = homeDir;

    sessionVariables = {
      XDG_CONFIG_HOME = homeDir + "/.config";
      XDG_DATA_HOME = homeDir + "/.local/share";
    };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./headless/neovim
    ./headless/nushell
    ./headless/git
    ./headless/zellij
    ./headless/eza
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    zoxide
    just
    broot
    bat
    # distant
  ];
}
