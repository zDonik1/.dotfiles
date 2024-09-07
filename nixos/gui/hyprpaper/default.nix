{ ... }:
let
  tropic-island-night = "~/wallpapers/tropic_island_night.jpg";
in
{
  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;
      preload = tropic-island-night;
      wallpaper = ", ${tropic-island-night}";
    };
  };
}
