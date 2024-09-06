
# Atuin 
# This part is copied from `atuin init`
set -gx ATUIN_SESSION (atuin uuid)
set --erase ATUIN_HISTORY_ID

function _atuin_preexec --on-event fish_preexec
    if not test -n "$fish_private_mode"
        set -g ATUIN_HISTORY_ID (atuin history start -- "$argv[1]")
    end

    set -g _atuin_ux_history_index 0
end

function _atuin_postexec --on-event fish_postexec
    set -l s $status

    if test -n "$ATUIN_HISTORY_ID"
        ATUIN_LOG=error atuin history end --exit $s -- $ATUIN_HISTORY_ID &>/dev/null &
        disown
    end

    set --erase ATUIN_HISTORY_ID
end

# User Extension
# This does change the up/down behaviour to use a "normal style" history with atuin
set -g _atuin_ux_history_index 0

function _atuin_ux_render_history 
    if [ "$_atuin_ux_history_index" = "0" ]
        commandline -r ""
        commandline -f repaint
        return
    end

    set -l ATUIN_HISTORY "$(ATUIN_SHELL_FISH=t ATUIN_LOG=error atuin history list --session --cmd-only --reverse false)"
    set -l ATUIN_LINE "$(echo $ATUIN_HISTORY | awk '{gsub(/\x0A/, "\n"); print}' | awk "NR==$_atuin_ux_history_index")"
    
    commandline -r "$ATUIN_LINE # Index: $_atuin_ux_history_index"
    commandline -f repaint
end

echo "$(ATUIN_SHELL_FISH=t ATUIN_LOG=error atuin history list --session --cmd-only --reverse false )"
function _atuin_ux_bind_up 
    set -g _atuin_ux_history_index (math "$_atuin_ux_history_index + 1")

    _atuin_ux_render_history
end

function _atuin_ux_bind_down
    set -g _atuin_ux_history_index (math "max($_atuin_ux_history_index - 1, 0)")

    _atuin_ux_render_history
end

# Bind keys
bind \cr _atuin_search

bind -k up _atuin_ux_bind_up
bind \eOA _atuin_ux_bind_up
bind \e\[A _atuin_ux_bind_up

bind -k down _atuin_ux_bind_down
bind \eOB _atuin_ux_bind_down
bind \e\[B _atuin_ux_bind_down


if bind -M insert > /dev/null 2>&1
    bind -M insert \cr _atuin_search

    bind -M insert -k up _atuin_ux_bind_up
    bind -M insert \eOA _atuin_ux_bind_up
    bind -M insert \e\[A _atuin_ux_bind_up

    bind -M insert -k down _atuin_ux_bind_down
    bind -M insert \eOB _atuin_ux_bind_down
    bind -M insert \e\[B _atuin_ux_bind_down
end
