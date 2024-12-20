{ ... }:

{
  users.users.zdonik = {
    extraGroups = [ "networkmanager" ];
  };

  networking.networkmanager.enable = true;
}
