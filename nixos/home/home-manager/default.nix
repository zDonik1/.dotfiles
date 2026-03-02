{ ... }:

{
  home = {
    # sessionVariables = {
    #   XDG_CONFIG_HOME = config.home.homeDirectory + "/.config";
    #   XDG_DATA_HOME = config.home.homeDirectory + "/.local/share";
    # };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.
  };

  # set XDG_*_HOME environment variables
  xdg.enable = true;

  # add home manager session variables to shells
  programs.bash.enable = true;
  programs.zsh.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
