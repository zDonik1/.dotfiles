{ ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    theme = "Catppuccin-Mocha";
    settings = {
      # couldn't select bold styles automatically
      bold_font = "family=\"JetBrainsMono Nerd Font\" style=\"Bold\"";
      italic_font = "auto";
      bold_italic_font = "family=\"JetBrainsMono Nerd Font\" style=\"Bold Italic\"";

      window_padding_width = "6 8";
    };
  };
}
