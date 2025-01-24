{ pkgs, ... }:

{
  users.users.zdonik = {
    extraGroups = [ "wireshark" ];
  };

  programs.wireshark.enable = true;

  environment.systemPackages = [ pkgs.wireshark ];
}
