{ pkgs, ... }:
let
  email = "doniyor@tokhirov.uz";
  name = "Doniyor Tokhirov";
  mocha = import ../../common/catppuccin-mocha.nix;
in
{
  imports = [
    ../neovim
  ];

  home.packages = with pkgs; [ lazyjj ];

  programs.git = {
    enable = true;

    settings = {
      user = { inherit email name; };

      alias = {
        s = "status";
        co = "checkout";
        st = "stash";
        adog = "log --all --decorate --oneline --graph";
        cm = "commit";
      };

      diff.colorMoved = "default";
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = { inherit email name; };

      ui = {
        editor = "nvim";
        default-command = "log";
        diff-editor = "nvim";
        merge-editor = "nvim";
      };

      revsets = {
        log = "ancestors(bookmarks() | remote_bookmarks() | visible_heads(), 3)";
      };

      merge-tools = {
        nvim = {
          program = "nvim";
          edit-args = [
            "-c"
            "DiffEditor $left $right $output"
          ];
          merge-args = [
            "-c"
            "let g:jj_diffconflicts_marker_length=$marker_length"
            "-c"
            "JJDiffConflicts!"
            "$output"
            "$base"
            "$left"
            "$right"
          ];
          merge-tool-edits-conflict-markers = true;
        };
      };

      lazyjj = {
        highlight-color = mocha.surface-0;
      };
    };
  };

  programs.nushell.shellAliases.ljj = "lazyjj -r \"all()\"";
}
