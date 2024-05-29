# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "virtio_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/mnt/wsl" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/usr/lib/wsl/drivers" = {
    device = "none";
    fsType = "9p";
  };

  fileSystems."/lib/modules" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/lib/modules/5.15.146.1-microsoft-standard-WSL2" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/05bcde6a-15d2-441a-8047-7ebb11e95a96";
    fsType = "ext4";
  };

  fileSystems."/mnt/wslg" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/usr/lib/wsl/lib" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/tmp/.X11-unix" = {
    device = "/mnt/wslg/.X11-unix";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/mnt/wslg/doc" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/mnt/c" = {
    device = "C:\134";
    fsType = "9p";
  };

  fileSystems."/mnt/d" = {
    device = "D:\134";
    fsType = "9p";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/f15be108-afea-4e71-8c92-c8922660b159"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}