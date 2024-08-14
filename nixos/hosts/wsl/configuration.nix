{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common-configuration.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "zdonik";
  wsl.nativeSystemd = true;

  networking.hostName = "DESKTOP-HHN7EQQ";
}
