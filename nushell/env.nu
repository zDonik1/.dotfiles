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

let is_windows = (sys | get host.name | str contains Windows)

# PATH entries
if $is_windows {
    $env.Path = ($env.Path | prepend 'C:/Program Files/Git/bin')
    $env.Path = ($env.Path | prepend 'C:/Users/tokhi/AppData/Local/distant/bin')
    $env.Path = ($env.Path | prepend 'C:/Users/tokhi/scoop/shims')
} else {
    $env.PATH = ($env.PATH | prepend '/home/linuxbrew/.linuxbrew/bin')
    $env.PATH = ($env.PATH | prepend '/opt/nvim-linux64/bin')
}

let home = if $is_windows { $env.USERPROFILE } else { $env.HOME }

$env.XDG_CONFIG_HOME = ($home | path join ".config")
$env.XDG_DATA_HOME = ($home | path join ".local/share")
$env.XDG_STATE_HOME = ($home | path join ".local/state")
$env.NVIM_LOG_FILE = ($home | path join ".cache/nvim/log")
$env.EDITOR = nvim
$env.LS_COLORS = (source ~/.config/nushell/themes/ls-themes/catppuccin-mocha.nu)
$env.LEDGER_FILE = "D:/ledger/2024.journal"
