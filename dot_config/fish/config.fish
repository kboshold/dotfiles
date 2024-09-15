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
    
    # function starship_transient_prompt_func
    #     starship module character
    # end
        
    # function starship_transient_rprompt_func
    #     starship prompt --right $argv
    # end
    # source ~/.config/fish/starship_init.fish
    # enable_transience    
end

if command -sq zellij
    bind  \e\[A\e\[A\e\[A 'zellij action switch-mode search'
    bind  \e\[B\e\[B\e\[B 'zellij action switch-mode search'

    bind -M insert \e\[A\e\[A\e\[A 'zellij action switch-mode search'
    bind -M insert \e\[B\e\[B\e\[B 'zellij action switch-mode search'

    bind -M visual \e\[A\e\[A\e\[A 'zellij action switch-mode search'
    bind -M visual \e\[B\e\[B\e\[B 'zellij action switch-mode search'
end

# At least required for the scroll. Otherwise Up/Down will not work well.
set -U fish_sequence_key_delay_ms 60

# Add tty to GPG_TTY for improved pinentry usage
set -gx GPG_TTY (tty)

source $HOME/.config/fish/aliases.fish
