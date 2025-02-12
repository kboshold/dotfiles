# Fish syntax highlighting
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

if ! status is-interactive
    exit;
end

function fish_greeting
end

# Magic stuff
# we go over A-Z and a-z and set a default that a Meta+A (and the other letters) does not trigger the escape in vi mode
for key in (string split '' 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
    bind -s -M visual \e$key ''
    bind -s -M insert \e$key ''
end

# General settings
fish_vi_key_bindings 

fish_add_path -g ~/.local/bin /usr/local/sbin /opt/nvim/bin

# Load mise
if command -sq mise
    mise activate fish | source

    # hook-env is required that the tools are directly available below
    mise hook-env -s fish | source;
end

if command -sq atuin
    atuin init fish | source    
    source ~/.config/fish/atuin_history.fish
end

if command -sq zoxide
    zoxide init --cmd cd fish | source
end

if command -sq starship
    # Prompt settings
    source ~/.config/fish/starship_async.fish
end

if command -sq fd
    set -gx  FZF_DEFAULT_COMMAND 'fd --type f'
else if command -sq rg
    set -gx  FZF_DEFAULT_COMMAND 'rg --files --hidden --glob=!.git/'
end

# At least required for the scroll. Otherwise Up/Down will not work well.
# set -U fish_sequence_key_delay_ms 60

# Add tty to GPG_TTY for improved pinentry usage
set -gx GPG_TTY (tty)

source $HOME/.config/fish/aliases.fish

function __fzf_inline_search
    set -l result (fzf)
    commandline -a $result
    commandline -f repaint
end

bind \ef -M insert __fzf_inline_search
