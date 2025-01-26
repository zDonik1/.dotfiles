{ pkgs, ... }:

{
  users = {
    users.zdonik = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
      ];
      initialHashedPassword = "a441b15fe9a3cf56661190a0b93b9dec7d04127288cc87250967cf3b52894d11";
    };
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
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  virtualisation.docker.enable = true;

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  nixpkgs.config.allowUnfree = true;
}
