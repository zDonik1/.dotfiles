{ config, zjstatus }:
let
  zjstatusPlugin = ''
    pane size=1 borderless=true {
        plugin location="file:${zjstatus}/bin/zjstatus.wasm" {
            format_left   "{mode} #[fg=#f2cdcd]  #[fg=#cdd6f4]{session} #[fg=#45475a]| {tabs}"
            format_right  "{notifications} #[fg=#74c7ec]#[fg=#11111b,bg=#74c7ec] #[fg=#cdd6f4,bg=#313244] {command_git_branch}#[fg=#313244] #[fg=#b4befe]#[fg=#11111b,bg=#b4befe] #[fg=#cdd6f4,bg=#313244] {swap_layout}#[fg=#313244] #[fg=#a6e3a1]#[fg=#11111b,bg=#a6e3a1] #[fg=#cdd6f4,bg=#313244] {command_user}@{command_host}#[fg=#313244] #[fg=#f38ba8]#[fg=#11111b,bg=#f38ba8]󰃭 {datetime}#[fg=#313244]"

            format_hide_on_overlength "true"
            format_precedence         "lrc"

            // border_enabled  "true"
            border_char     "─"
            border_format   "#[fg=#313244]{char}"
            border_position "bottom"

            mode_normal       "#[fg=#89b4fa]#[bg=#89b4fa,fg=#11111b,bold]NORMAL#[fg=#89b4fa]"
            mode_tmux         "#[fg=#a6e3a1]#[bg=#a6e3a1,fg=#11111b,bold]PREFIX#[fg=#a6e3a1]"
            mode_tab          "#[fg=#fab387]#[bg=#fab387,fg=#11111b,bold]TAB#[fg=#fab387]"
            mode_pane         "#[fg=#fab387]#[bg=#fab387,fg=#11111b,bold]PANE#[fg=#fab387]"
            mode_rename_tab   "#[fg=#f9e2af]#[bg=#f9e2af,fg=#11111b,bold]RENAME#[fg=#f9e2af]"
            mode_rename_pane  "#[fg=#f9e2af]#[bg=#f9e2af,fg=#11111b,bold]RENAME#[fg=#f9e2af]"
            mode_scroll       "#[fg=#eba0ac]#[bg=#eba0ac,fg=#11111b,bold]SCROLL#[fg=#eba0ac]"
            mode_enter_search "#[fg=#eba0ac]#[bg=#eba0ac,fg=#11111b,bold]SEARCH#[fg=#eba0ac]"
            mode_resize       "#[fg=#cba6f7]#[bg=#cba6f7,fg=#11111b,bold]RESIZE#[fg=#cba6f7]"

            //tab_active "#[fg=#f5c2e7]{floating_indicator}{fullscreen_indicator}{sync_indicator} #[fg=#313244]#[fg=#cdd6f4,bg=#313244,bold] {name} #[fg=#313244,bg=#fab387]#[fg=#11111b,bg=#fab387,bold] {index} #[fg=#fab387] "
            //tab_normal "#[fg=#313244]#[fg=#cdd6f4,bg=#313244] {name} #[fg=#313244,bg=#b4befe]#[fg=#11111b,bg=#b4befe] {index} #[fg=#b4befe] "
            tab_active "#[fg=#fab387,italic,bold] {name} #[fg=#94e2d5]{floating_indicator}{fullscreen_indicator}{sync_indicator}"
            tab_normal "#[fg=#585b70,italic] {name} "
            tab_sync_indicator       "󰓦 "
            tab_fullscreen_indicator "󰊓 "
            tab_floating_indicator   "󰖲 "

            notification_format_unread           "#[fg=#f9e2af]#[fg=#11111b,bg=#f9e2af] #[fg=#cdd6f4,bg=#313244] {message}#[fg=#313244]"
            notification_format_no_notifications ""
            notification_show_interval           "10"

            command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
            command_git_branch_format      "{stdout}"
            command_git_branch_interval    "10"
            command_git_branch_rendermode  "static"

            command_host_command    "uname -n"
            command_host_format     "{stdout}"
            command_host_interval   "10"
            command_host_rendermode "static"
            
            command_user_command    "whoami"
            command_user_format     "{stdout}"
            command_user_interval   "10"
            command_user_rendermode "static"

            datetime          "#[fg=#cdd6f4,bg=#313244] {format}"
            datetime_format   "%a, %Y-%m-%d  󰅐 %H:%M"
            datetime_timezone "Asia/Tashkent"
        }
    }
  '';

  defaultTabTemplate =
    {
      children ? "children",
    }:
    ''
      default_tab_template {
          ${zjstatusPlugin}
          ${children}
      }
    '';
in
{
  default = ''
    layout {
        ${defaultTabTemplate {
          children = ''
            pane split_direction="vertical" {
                children
                pane
                pane focus=true size="30%"
            }
          '';
        }}
    }
  '';

  defaultSwap = ''
    swap_tiled_layout name="vertical" {
        tab max_panes=5 {
            pane split_direction="vertical" {
                pane
                pane { children; }
            }
        }
        tab max_panes=8 {
            pane split_direction="vertical" {
                pane { children; }
                pane { pane; pane; pane; pane; }
            }
        }
        tab max_panes=12 {
            pane split_direction="vertical" {
                pane { children; }
                pane { pane; pane; pane; pane; }
                pane { pane; pane; pane; pane; }
            }
        }
    }

    swap_tiled_layout name="horizontal" {
        tab max_panes=5 {
            pane
            pane
        }
        tab max_panes=8 {
            pane {
                pane split_direction="vertical" { children; }
                pane split_direction="vertical" { pane; pane; pane; pane; }
            }
        }
        tab max_panes=12 {
            pane {
                pane split_direction="vertical" { children; }
                pane split_direction="vertical" { pane; pane; pane; pane; }
                pane split_direction="vertical" { pane; pane; pane; pane; }
            }
        }
    }

    swap_tiled_layout name="stacked" {
        tab min_panes=5 {
            pane split_direction="vertical" {
                pane
                pane stacked=true { children; }
            }
        }
    }

    swap_floating_layout name="staggered" {
        floating_panes
    }

    swap_floating_layout name="enlarged" {
        floating_panes max_panes=10 {
            pane { x "5%"; y 1; width "90%"; height "90%"; }
            pane { x "5%"; y 2; width "90%"; height "90%"; }
            pane { x "5%"; y 3; width "90%"; height "90%"; }
            pane { x "5%"; y 4; width "90%"; height "90%"; }
            pane { x "5%"; y 5; width "90%"; height "90%"; }
            pane { x "5%"; y 6; width "90%"; height "90%"; }
            pane { x "5%"; y 7; width "90%"; height "90%"; }
            pane { x "5%"; y 8; width "90%"; height "90%"; }
            pane { x "5%"; y 9; width "90%"; height "90%"; }
            pane focus=true { x 10; y 10; width "90%"; height "90%"; }
        }
    }

    swap_floating_layout name="spread" {
        floating_panes max_panes=1 {
            pane {y "50%"; x "50%"; }
        }
        floating_panes max_panes=2 {
            pane { x "1%"; y "25%"; width "45%"; }
            pane { x "50%"; y "25%"; width "45%"; }
        }
        floating_panes max_panes=3 {
            pane focus=true { y "55%"; width "45%"; height "45%"; }
            pane { x "1%"; y "1%"; width "45%"; }
            pane { x "50%"; y "1%"; width "45%"; }
        }
        floating_panes max_panes=4 {
            pane { x "1%"; y "55%"; width "45%"; height "45%"; }
            pane focus=true { x "50%"; y "55%"; width "45%"; height "45%"; }
            pane { x "1%"; y "1%"; width "45%"; height "45%"; }
            pane { x "50%"; y "1%"; width "45%"; height "45%"; }
        }
    }

  '';

  journal =
    let
      homeDir = config.home.homeDirectory;
    in
    ''
      layout {
          ${defaultTabTemplate { }}
          
          tab name="jrn" {
              pane name="journal" command="nvim" cwd="~/SecondBrain"
          }
          tab name="ledger" split_direction="vertical" cwd="~/ledger" {
              pane name="ledger" size="40%" command="nvim"
              pane name="report" command="just" {
                  args "dev"
              }
          }
          tab name="time" focus=true split_direction="vertical" {
              pane size="40%" {
                  pane name="2 day summary" size="40%" command="watchexec" {
                      args "-qc" "-w" "${homeDir}/.local/share/timewarrior/data" \
                           "timew sum 1days ago"
                  }
                  pane name="time budget" size="25%" command="watchexec" {
                      args "-qc" "--shell" "nu" "-w" "${homeDir}/.local/share/timewarrior/data" \
                           "source $nu.config-path; twbud"
                  }
                  pane
              }
              pane {
                  pane name="2 week report" size="30%" command="watchexec" {
                      args "-qc" "-w" "${homeDir}/.local/share/timewarrior/data" \
                           "timew week 14days before tomor"
                  }
                  pane name="tasks" command="taskwarrior-tui"
              }
          }
      }
    '';
}
