{ ... }:

{
  networking.hosts = {
    "127.0.0.1" = [
      "zdonik-pc.mukhtarov.net"
      "zdonik-pc"
    ];
    "192.168.100.51" = [ "diskstation.mukhtarov.net" ];
  };

  security.krb5 = {
    enable = true;
    settings = {
      libdefaults.default_realm = "MUKHTAROV.NET";
      domain_realm."kdc.mukhtarov.net" = "MUKHTAROV.NET";
      realms."MUKHTAROV.NET" = {
        kdc = "kdc.mukhtarov.net";
        admin_server = "kdc.mukhtarov.net";
      };
    };
  };

  fileSystems."/mnt/ds/homes" = {
    device = "diskstation.mukhtarov.net:/volume1/homes";
    fsType = "nfs";
    options = [
      "sec=krb5"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
    ];
  };
}
