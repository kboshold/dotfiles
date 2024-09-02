# Nushell Environment Config File
#
# version = "0.96.1"


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

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

mkdir ~/.cache/starship ~/.cache/oh-my-posh ~/.cache/zoxide ~/.cache/atuin
if (which starship | is-not-empty) {
    echo "" | save -f ~/.cache/oh-my-posh/init.nu
    starship init nu | save -f ~/.cache/starship/init.nu
} else if (which oh-my-posh | is-not-empty) {
    echo "" | save -f ~/.cache/starship/init.nu
    oh-my-posh init nu --config ~/.config/oh-my-posh/config.json --print | safe -f ~/.cache/oh-my-posh/init.nu
} else {
    echo "" | save -f ~/.cache/starship/init.nu
    echo "" | save -f ~/.cache/oh-my-posh/init.nu
}

if (which atuin  | is-not-empty) {
    atuin init nu | save ~/.cache/atuin/init.nu
} else {
    echo "" | save -f ~/.cache/atuin/init.nu
}

if (which zoxide | is-not-empty) {
    zoxide init nushell | save -f  ~/.cache/zoxide/init.nu
} else {
    echo "" | save -f ~/.cache/zoxide/init.nu
}

def get_transient_prompt_command_right [] {
    mut result = "";
    if ($env.LAST_EXIT_CODE) != 0 {
        $result += $"(ansi --escape {fg: '#f38ba8'})󱗗 ($env.LAST_EXIT_CODE)(ansi reset) "
    }
    if ($env.CMD_DURATION_MS | into int) > 2000 {
        $result += $"(ansi --escape {fg: '#fe640b'})took ($env.CMD_DURATION_MS + "ms" | into duration)(ansi reset) "
    }
    $result += $"(ansi --escape {fg: '#b4befe'})at (date now | format date '%H:%M:%S')(ansi reset)"
    return $result
}

$env.TRANSIENT_PROMPT_COMMAND = {|| $"\n(ansi --escape {fg: '#89b4fa'})❯(ansi --escape {fg: '#b4befe'})❯(ansi reset) " }
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| $"(get_transient_prompt_command_right)" }
$env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "   " }

$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = {|| $"\b\b\b(ansi --escape {fg: '#5f5faf'})N(ansi --escape {fg: '#7598d1'})❯(ansi reset) " }
$env.PROMPT_MULTILINE_INDICATOR = ""


