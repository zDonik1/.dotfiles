{ ... }:

{
  services = {
    xserver = {
      enable = true;

      desktopManager.plasma5.enable = true;
      desktopManager.plasma5.useQtScaling = true;
    };

    displayManager.sddm.enable = true;
  };
}
