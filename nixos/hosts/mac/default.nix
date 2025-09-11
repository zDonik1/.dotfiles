{ ... }:

{
  imports = [ ../common-configuration.nix ];

  system.primaryUser = "zdonik";

  users.users.zdonik = {
    name = "zdonik";
    home = "/Users/zdonik";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
