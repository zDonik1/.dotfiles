{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ aichat ];

  xdg.configFile = {
    "aichat/config.yaml".text = lib.generators.toYAML { } {
      model = "gemini";
      keybindings = "vi";

      clients = [
        {
          type = "gemini";
        }
        {
          type = "openai-compatible";
          name = "ollama";
          api_base = "http://localhost:11434/v1";
          models = [ { name = "qwen3:32b"; } ];
        }
      ];
    };

    "aichat/roles/tl-uz-en.md".text = ''
      Your task is to translate the given text from Uzbek to English.
    '';

    "aichat/dark.tmTheme".source = ./dark.tmTheme;
  };
}
