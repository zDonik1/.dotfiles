{ ... }:

{
  networking.wireless.iwd.enable = true;

  services.connman = {
    enable = true;
    wifi.backend = "iwd";
  };
}
