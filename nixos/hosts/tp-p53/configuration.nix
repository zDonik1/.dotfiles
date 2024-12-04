{ pkgs, pkgs-stable, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common-configuration.nix
  ];

  users.users.zdonik = {
    extraGroups = [ "networkmanager" ];
  };

  boot = {
    kernelPackages = pkgs-stable.linuxPackages;
    kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "DTOKHIROV";
    wireless.iwd.enable = true;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        intel-media-driver
      ];
    };

    # xserver.videoDrivers = [ "nvidia" ]; should be there for nvidia to work
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      powerManagement.enable = true;

      prime = {
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  services = {
    getty.autologinUser = "zdonik";
    printing.enable = true;
    openssh.enable = true;
    udisks2.enable = true;
    xserver.videoDrivers = [ "nvidia" ]; # loads nvidia drivers for Wayland as well

    connman = {
      enable = true;
      wifi.backend = "iwd";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };

  programs = {
    firefox.enable = true;
    hyprland.enable = true;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    systemPackages = with pkgs; [ kdePackages.polkit-kde-agent-1 ];
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  nixpkgs.config.allowUnfree = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
