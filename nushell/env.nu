# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

let is_windows = (sys host | get name | str contains Windows)

# PATH entries
if $is_windows {
    $env.Path = ($env.Path | prepend 'C:/Program Files/Git/bin')
    $env.Path = ($env.Path | prepend 'C:/Users/tokhi/AppData/Local/distant/bin')
    $env.Path = ($env.Path | prepend 'C:/Users/tokhi/scoop/shims')
    $env.Path = ($env.Path | prepend 'C:/Program Files/Wireshark')
} else {
    $env.PATH = ($env.PATH | prepend '/home/linuxbrew/.linuxbrew/bin')
    $env.PATH = ($env.PATH | prepend '/opt/nvim-linux64/bin')
}

if $is_windows {
    $env.HOME = $env.USERPROFILE
}

$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
$env.XDG_STATE_HOME = ($env.HOME | path join ".local/state")
$env.NVIM_LOG_FILE = ($env.HOME | path join ".cache/nvim/log")
$env.CPM_SOURCE_CACHE = ($env.HOME | path join ".cache/CPM")
$env.EDITOR = "nvim"
$env.PAGER = "less"
$env.BROWSER = "firefox"
$env.SHELL = "nu"
$env.LS_COLORS = (source ~/.config/nushell/themes/ls-themes/catppuccin-mocha.nu)

$env.LEDGER_FILE = if $is_windows { "D:/ledger/2024.journal" } else { $env.HOME | path join "ledger/2024.journal" }
$env.FZF_DEFAULT_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git"
$env.FZF_DEFAULT_OPTS = (
    [
        "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8"
        "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
        "--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
        "--preview 'bat -n --color=always {}'"
        "--height=~50%"
    ]
    | str join " "
)
$env.VIRTUAL_ENV_DISABLE_PROMPT = 1
