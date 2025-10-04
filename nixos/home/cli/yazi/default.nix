{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    extraPackages = with pkgs; [
      ffmpegthumbnailer
      p7zip
      jq
      poppler
      fd
      ripgrep
      fzf
      zoxide
      imagemagick
      exiftool
      mediainfo
    ];

    initLua = ./init.lua;
    shellWrapperName = "y";

    settings = {
      mgr = {
        linemode = "size_and_mtime";
        show_hidden = true;
        scrolloff = 5;
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "<C-s>";
          run = "arrow -50%";
          desc = "Move cursor up half page";
        }
        {
          on = "<C-t>";
          run = "arrow 50%";
          desc = "Move cursor down half page";
        }
        {
          on = "<C-x>";
          run = "escape --search";
          desc = "Cancel the ongoing search";
        }
      ];
    };
  };
}
