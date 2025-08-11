{ pkgs, ... }:
let
  email = "doniyor@tokhirov.uz";
  name = "Doniyor Tokhirov";
in
{
  home.packages = with pkgs; [
    git-machete
    gitui
    gh-dash
    neovim
  ];

  programs.git = {
    enable = true;
    userEmail = email;
    userName = name;

    aliases = {
      s = "status";
      co = "checkout";
      st = "stash";
      adog = "log --all --decorate --oneline --graph";
      cm = "commit";
    };

    extraConfig = {
      diff.colorMoved = "default";
      include.path = "${./catppuccin.gitconfig}";
    };

    delta = {
      enable = true;
      options = {
        features = "catppuccin-mocha";
        line-numbers = true;
        side-by-side = true;
      };
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
        pager = "delta";
        diff-formatter = ":git";
        diff-editor = "nvim";
        merge-editor = "nvim";
      };

      merge-tools = {
        delta = {
          diff-expected-exit-codes = [
            0
            1
          ];
        };

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
    };
  };
}
