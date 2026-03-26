{ ... }:

{
  programs.mise = {
    enable = true;
    globalConfig = {
      settings = {
        experimental = true;
      };
    };
  };
}
