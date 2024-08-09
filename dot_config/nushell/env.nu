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

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

def get_transient_prompt_command_right [] {
    mut result = "";
    if ($env.LAST_EXIT_CODE) != 0 {
        $result += $"(ansi --escape {fg: '#540a0a'})󱗗 ($env.LAST_EXIT_CODE)(ansi reset) "
    }
    if ($env.CMD_DURATION_MS | into int) > 2000 {
        $result += $"(ansi --escape {fg: '#1c2a40'})took ($env.CMD_DURATION_MS + "ms" | into duration)(ansi reset) "
    }
    $result += $"(ansi --escape {fg: '#1c2a40'})at (date now | format date '%H:%M:%S')(ansi reset)"
    return $result
}

$env.TRANSIENT_PROMPT_COMMAND = {|| $"\n(ansi --escape {fg: '#5f5faf'})❯(ansi --escape {fg: '#7598d1'})❯(ansi reset) " }
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| $"(get_transient_prompt_command_right)" }
$env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "   " }

$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = {|| $"\b\b\b(ansi --escape {fg: '#5f5faf'})N(ansi --escape {fg: '#7598d1'})❯(ansi reset) " }
$env.PROMPT_MULTILINE_INDICATOR = ""
