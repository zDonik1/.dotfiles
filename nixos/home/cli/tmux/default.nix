{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.programs) nushell;
in
{
  programs.tmux = {
    enable = true;

    mouse = true;
    baseIndex = 1;
    prefix = "C-Space";
    shell = if nushell.enable then lib.getExe nushell.package else null;
    disableConfirmationPrompt = true;

    extraConfig = ''
      set -g default-command "${lib.getExe nushell.package} -l"
      set -as terminal-features "xterm*:extkeys:RGB"
      set -s extended-keys on

      # ============================================
      # KEY BINDINGS
      # ============================================

      bind r source-file ${config.xdg.configHome}/tmux/tmux.conf \; display "Config reloaded!"

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Vim-style pane navigation
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Vim-style pane resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      bind -n C-0 select-window -t 0
      bind -n C-1 select-window -t 1
      bind -n C-2 select-window -t 2
      bind -n C-3 select-window -t 3
      bind -n C-4 select-window -t 4
      bind -n C-5 select-window -t 5
      bind -n C-6 select-window -t 6
      bind -n C-7 select-window -t 7
      bind -n C-8 select-window -t 8
      bind -n C-9 select-window -t 9

      # ============================================
      # APPEARANCE
      # ============================================

      # Status bar position
      set -g status-position top

      # ============================================
      # COPY MODE
      # ============================================

      # Use vi keys
      setw -g mode-keys vi

      # Vi-style copy bindings
      bind -T copy-mode-vi v send -X begin-selection
      ${
        if pkgs.stdenv.hostPlatform.isDarwin then
          ''bind -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"''
        else
          ''bind -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -selection clipboard -i"''
      }
    '';

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.cpu
      tmuxPlugins.battery
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
  };

  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"

    set -g status-right-length 100
    set -g status-left-length 100
    set -g status-left ""
    set -g status-right "#{E:@catppuccin_status_application}"
    set -agF status-right "#{E:@catppuccin_status_cpu}"
    set -ag status-right "#{E:@catppuccin_status_session}"
    set -ag status-right "#{E:@catppuccin_status_uptime}"
    set -agF status-right "#{E:@catppuccin_status_battery}"
  '';
}
