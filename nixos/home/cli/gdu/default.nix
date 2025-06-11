{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ gdu ];

  xdg.configFile."gdu/gdu.yaml".text = lib.generators.toYAML { } {
    style = {
      selected-row = {
        text-color = "green";
        background-color = "#45475a";
      };
      footer = {
        text-color = "#94e2d5";
        background-color = "#313244";
        number-color = "#fab387";
      };
      header = {
        hidden = true;
      };
      result-row = {
        number-color = "#fab387";
        directory-color = "blue";
      };
    };
  };
}
