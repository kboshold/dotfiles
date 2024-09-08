# User Extension
# This does change the up/down behaviour to use a "normal style" history with atuin
function _autin_ux_reset --on-event fish_preexec
    set -g _atuin_ux_history_index -1
    set -g _atuin_ux_history_commannd ""
end

function _atuin_ux_render_history 
    if [ "$_atuin_ux_history_index" = "-1" ]
        commandline -r "$_atuin_ux_history_commannd"
        commandline -f repaint
        return
    end

    set -l ATUIN_LINE "$(ATUIN_SHELL_FISH=t ATUIN_LOG=error atuin search --filter-mode session --cmd-only --offset $_atuin_ux_history_index --limit 1 --search-mode prefix $_atuin_ux_history_commannd )"
    if [ "$ATUIN_LINE" = "" ]
        set -g _atuin_ux_history_index (math "max($_atuin_ux_history_index - 1, -1)")
        return;
    end

    commandline -r "$ATUIN_LINE"
    commandline -f repaint
end

function _atuin_ux_bind_up 
    if [ "$_atuin_ux_history_index" = "-1" ]
        set -g _atuin_ux_history_commannd "$(commandline -b)"
    end
    set -g _atuin_ux_history_index (math "$_atuin_ux_history_index + 1")

    _atuin_ux_render_history
end

function _atuin_ux_bind_down
    set -g _atuin_ux_history_index (math "max($_atuin_ux_history_index - 1, -1)")

    _atuin_ux_render_history
end

# Override atuin bind up
function _atuin_bind_up
    _atuin_ux_bind_up
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

    bind -M visual -M default j _atuin_ux_bind_down
    bind -M visual -M default k _atuin_ux_bind_up
end

_autin_ux_reset