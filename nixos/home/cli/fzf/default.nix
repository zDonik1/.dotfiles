{ ... }:

{
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    defaultOptions = [
      "--preview 'bat -n --color=always {}'"
      "--height=~50%"
    ];
  };
}
