{ ... }:

{
  services.hypridle = {
    enable = true;

    settings = {
      listener = [
        # causing issues with the display
        # {
        #   timeout = 800;
        #   on-timeout = "hyprctl dispatch dpms off";
        #   on-resume = "hyprctl dispatch dpms on";
        # }
        {
          timeout = 1200;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
