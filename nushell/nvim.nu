$env.config = {
    show_banner: false
    ls: {
        use_ls_colors: false
        clickable_links: false
    }
    rm: { always_trash: false }

    table: {
        mode: none # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
        index_mode: never # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
        show_empty: true # show 'empty list' and 'empty record' placeholders for command output
        padding: { left: 1, right: 1 } # a left right padding of each column in a table
        trim: {
            methodology: truncating # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
        }
    }

    error_style: "plain" # "fancy" or "plain" for screen reader-friendly error messages

    # explore: {
    #     status_bar_background: {fg: "#1D1F21", bg: "#C4C9C6"},
    #     command_bar_text: {fg: "#C4C9C6"},
    #     highlight: {fg: "black", bg: "yellow"},
    #     status: {
    #         error: {fg: "white", bg: "red"},
    #         warn: {}
    #         info: {}
    #     },
    #     table: {
    #         split_line: {fg: "#404040"},
    #         selected_cell: {bg: light_blue},
    #         selected_row: {},
    #         selected_column: {},
    #     },
    # }

    filesize: {
        metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
        format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, auto
    }

    use_ansi_coloring: false
    use_grid_icons: false
    footer_mode: "25" # always, never, number_of_rows, auto
    float_precision: 2 # the precision for displaying floats in tables
    bracketed_paste: true # enable bracketed paste, currently useless on windows
    edit_mode: vi
    shell_integration: false # enables terminal shell integration. Off by default, as some terminals have issues with this.
    render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
    use_kitty_protocol: false # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
    highlight_resolved_externals: false # true enables highlighting of external commands in the repl resolved by which.
}
