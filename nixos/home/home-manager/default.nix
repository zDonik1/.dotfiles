{ pkgs, config, ... }:
let
  # set the env vars since the default shell is nushell
  _ = pkgs.runCommand "set-env-vars" { } ''
    source $env.HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
  '';
in
{
  home = {
    sessionVariables = {
      XDG_CONFIG_HOME = config.home.homeDirectory + "/.config";
      XDG_DATA_HOME = config.home.homeDirectory + "/.local/share";
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
}
