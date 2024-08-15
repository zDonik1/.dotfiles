{ pkgs, ... }:

{
  users = {
    users.zdonik = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      initialHashedPassword = "a441b15fe9a3cf56661190a0b93b9dec7d04127288cc87250967cf3b52894d11";
    };
    defaultUserShell = pkgs.nushell;
  };

  time.timeZone = "Asia/Tashkent";

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
    shells = [ pkgs.nushell ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
