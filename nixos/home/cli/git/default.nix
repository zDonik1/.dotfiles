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
    settings.user = {
      inherit email name;
    };
  };
}
