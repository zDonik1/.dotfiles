let starship_exec = if (sys | get host.name | str contains Windows) { 'C:\Program Files\starship\bin\starship.exe'  } else { "/home/linuxbrew/.linuxbrew/bin/starship" }

export-env { load-env {
    STARSHIP_SHELL: "nu"
    STARSHIP_SESSION_KEY: (random chars -l 16)
    PROMPT_MULTILINE_INDICATOR: (
        ^$starship_exec prompt --continuation
    )

    # Does not play well with default character module.
    # TODO: Also Use starship vi mode indicators?
    PROMPT_INDICATOR: ""

    PROMPT_COMMAND: { gen_left_prompt }

    config: ($env.config? | default {} | merge {
        render_right_prompt_on_last_line: true
    })

    PROMPT_COMMAND_RIGHT: {||
        (
            ^$starship_exec prompt
                --right
                --cmd-duration $env.CMD_DURATION_MS
                $"--status=($env.LAST_EXIT_CODE)"
                --terminal-width (term size).columns
        )
    }
}}

export def gen_left_prompt [] {
    (
        ^$starship_exec prompt
            --cmd-duration $env.CMD_DURATION_MS
            $"--status=($env.LAST_EXIT_CODE)"
            --terminal-width (term size).columns
    )
}
