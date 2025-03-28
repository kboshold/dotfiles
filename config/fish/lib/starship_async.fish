set -g __starship_async_tmpdir (command mktemp -d)
set -g __starship_async_instant_file "$HOME/.cache/fish/starship_shell"
set -g __starship_async_update_instant_file "true"
set -g __starship_async_signal SIGUSR1

# Starship variables
set -g VIRTUAL_ENV_DISABLE_PROMPT 1
builtin functions -e fish_mode_prompt
set -gx STARSHIP_SHELL fish

if command -sq atuin
    set -gx STARSHIP_SESSION_KEY (atuin uuid)
else 
    set -gx STARSHIP_SESSION_KEY (random 10000000000000 9999999999999999)
end

if not test -e "$__starship_async_instant_file"
    mkdir -p (dirname "$__starship_async_instant_file")
end

# Fish propmpts
function fish_prompt
    __starship_update_variables

    if test $TRANSIENT -eq 1 &> /dev/null
         printf \e\[0J\n
        __starship_left_transient_prompt
    else 
        __starship_left_prompt
    end
end

function fish_right_prompt
    __starship_update_variables

    if test $TRANSIENT -eq 1 &> /dev/null
        __starship_right_transient_prompt
    else 
        __starship_right_prompt
    end
end

# Custom functions

function __starship_update_variables 
    # Get properties for fish
    switch "$fish_key_bindings"
        case fish_hybrid_key_bindings fish_vi_key_bindings
            set -g STARSHIP_KEYMAP "$fish_bind_mode"
        case '*'
            set -g STARSHIP_KEYMAP insert
    end

    set -g STARSHIP_CMD_PIPESTATUS $pipestatus
    set -g STARSHIP_CMD_STATUS $status
    set -g CUSTOM_CMD_STATUS $status
    set -g STARSHIP_DURATION "$CMD_DURATION$cmd_duration"
    set -g STARSHIP_JOBS (count (jobs -p))
end

function __starship_left_prompt
    if test -e "$__starship_async_tmpdir/$fish_pid""_fish_prompt"
        # set PROMPT (cat $__starship_async_tmpdir/$fish_pid""_fish_prompt)
        read -z -d '' PROMPT < $__starship_async_tmpdir/$fish_pid"_fish_prompt"
        if test "$__starship_async_update_instant_file" = "true"
            set -g __starship_async_update_instant_file "false"
            if test "$PWD" = "$HOME"; 
                if not test  "$PROMPT" = ""
                    echo $PROMPT > $__starship_async_instant_file
                end
            end
        end

        # cat $__starship_async_tmpdir/$fish_pid""_fish_prompt
        echo -n $PROMPT
    else if test -e "$__starship_async_instant_file"
        cat "$__starship_async_instant_file"
    else 
        __starship_left_transient_prompt
    end
end

function __starship_right_prompt
    starship prompt --right --terminal-width="$COLUMNS" --status=$STARSHIP_CMD_STATUS --pipestatus="$STARSHIP_CMD_PIPESTATUS" --keymap=$STARSHIP_KEYMAP --cmd-duration=$STARSHIP_DURATION --jobs=$STARSHIP_JOBS
end

function __starship_left_transient_prompt
    starship module character
end

function __starship_right_transient_prompt
    __starship_right_prompt
end

function __starship_async_fire --on-event fish_prompt
    __starship_update_variables

    set -l tmpfile "$__starship_async_tmpdir/$fish_pid""_fish_prompt"

    fish -c '
        starship prompt --terminal-width="'$COLUMNS'" --status='$STARSHIP_CMD_STATUS' --pipestatus="'$STARSHIP_CMD_PIPESTATUS'" --keymap='$STARSHIP_KEYMAP' --cmd-duration='$STARSHIP_DURATION' --jobs='$STARSHIP_JOBS' > '$tmpfile'
        kill -s "'$__starship_async_signal'" '$fish_pid &

    disown
end

function __starship_async_mode_switch --on-variable fish_bind_mode
    commandline -f repaint
    __starship_async_fire
end

function __starship_async_repaint_prompt --on-signal "$__starship_async_signal"
    commandline -f repaint
end

function __starship_async_cancel_repaint --on-event fish_cancel
    set -g TRANSIENT 0
    commandline -f repaint
end

function __starship_async_focus_repaint --on-event fish_focus_in
    commandline -f repaint
end

function __starship_async_cleanup --on-event fish_exit
    rm -f "$__starship_async_tmpdir/$fish_pid""_fish_prompt"
end

function __starship_async_cancel_commandline
    if string length -q -- (commandline)
        set -g TRANSIENT 1
        commandline -f repaint
    end
    commandline -f cancel-commandline
end

function __starship_async_edit_command_buffer
    printf '\e[2F' # 2 lines up
    edit_command_buffer
end

function __starship_async_maybe_execute
    if test "$fish_bind_mode" != "insert"
        set fish_bind_mode insert
    end

    if commandline --is-valid
        set -g TRANSIENT 1
        commandline -f repaint
    else
        set -g TRANSIENT 0
    end

    commandline -f execute
end

function __starship_async_reset_transient --on-event fish_postexec
    set -g TRANSIENT 0
end

bind \r  __starship_async_maybe_execute       # ENTER
bind \cc __starship_async_cancel_commandline  # CTRL+C
bind \ee __starship_async_edit_command_buffer # ALT+E
bind \ev __starship_async_edit_command_buffer # ALT+V

if bind -M insert > /dev/null 2>&1
    bind --user -M insert \r __starship_async_maybe_execute
    bind --user -M insert \cc __starship_async_cancel_commandline  # CTRL+C
    bind --user -M insert \ee __starship_async_edit_command_buffer # ALT+E
    bind --user -M insert \ev __starship_async_edit_command_buffer # ALT+V
end

