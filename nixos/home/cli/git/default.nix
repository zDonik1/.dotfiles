{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git-machete
    gitui
    gh-dash
  ];

  programs.git = {
    enable = true;
    userEmail = "doniyor@tokhirov.uz";
    userName = "Doniyor Tokhirov";

    aliases = {
      s = "status";
      co = "checkout";
      st = "stash";
      adog = "log --all --decorate --oneline --graph";
      cm = "commit";
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
}
