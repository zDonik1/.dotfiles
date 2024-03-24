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

# PATH entries
$env.Path = ($env.Path | split row (char esep) | prepend 'D:/tools/vivid')
$env.Path = ($env.Path | split row (char esep) | prepend 'C:/Program Files/Git/bin')


if (which vivid | length) > 0 {
    $env.LS_COLORS = (vivid generate catppuccin-mocha | str trim)
} else {
    $env.LS_COLORS = (source ./themes/ls-themes/catppuccin-mocha.nu)
}
$env.XDG_CONFIG_HOME = ($env.USERPROFILE | path join ".config")
$env.XDG_DATA_HOME = ($env.USERPROFILE | path join ".local/share")
$env.XDG_STATE_HOME = ($env.USERPROFILE | path join ".local/state")
$env.NVIM_LOG_FILE = ($env.USERPROFILE | path join ".cache/nvim/log")
$env.EDITOR = nvim
$env.LEDGER_FILE = "D:/ledger/2024.journal"
