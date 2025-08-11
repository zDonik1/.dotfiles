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

  programs.jujutsu =
    let
      nvimdiff = pkgs.writeShellScriptBin "nvimdiff" ''
        left=$1
        right=$2
        rm -f "$right/JJ-INSTRUCTIONS"
        git -C "$left" init -q
        git -C "$left" add -A
        git -C "$left" commit -q -m baseline --allow-empty # create parent commit
        mv "$left/.git" "$right"
        git -C "$right" add --intent-to-add -A # create current working copy
        (cd "$right"; nvim +DiffviewOpen)
        git -C "$right" diff-index --quiet --cached HEAD && { echo "No changes done, aborting split."; exit 1; }
        git -C "$right" commit -q -m split # create commit on top of parent including changes
        git -C "$right" restore . # undo changes in modified files
        git -C "$right" reset .   # undo --intent-to-add
        git -C "$right" clean -q -df # remove untracked files
      '';
    in
    {
      enable = true;
      settings = {
        user = { inherit email name; };

        ui = {
          editor = "nvim";
          default-command = "log";
          pager = "delta";
          diff-formatter = ":git";
          diff-editor = "nvim";
        };

        merge-tools = {
          nvim = {
            program = "${nvimdiff}/bin/nvimdiff";
          };
          delta = {
            diff-expected-exit-codes = [
              0
              1
            ];
          };
        };
      };
    };
}
