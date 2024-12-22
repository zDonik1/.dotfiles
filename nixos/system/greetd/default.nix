{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "zdonik";
      };

      default_session = {
        command = "agreet -c Hyprland";
      };
    };
  };
}
