# typos
abbr clr clear
abbr dc cd
abbr sl ls
abbr pdw pwd
abbr dir ls
abbr q exit

function _define_cd_levels
    set -l dots
    set -l levels
    for i in (seq 1 9)
        set dots ".$dots"
        set levels "../$levels"

        abbr -a ".$i" "cd $levels"
        abbr -a ".$dots" "cd $levels"
        abbr -a "cd.$dots" "cd $levels"
        abbr -a "cd$i" "cd $levels"
    end
end
_define_cd_levels

if command -sq fd && command -sq fzf
    # Shared preview commands
    function _get_dir_preview
        if command -sq eza
            echo "eza --long --color=always --all --icons --git --hyperlink -g {}"
        else
            echo "ls -la {}"
        end
    end

    function _get_file_preview
        if command -sq bat
            echo "bat --color=always --style=plain {}"
        else
            echo "cat {}"
        end
    end

    function find-file
        set -l file_preview (_get_file_preview)
        echo (fd -0 --type f --hidden | fzf --read0 --preview $file_preview --query "$argv")
    end

    function find-directory
        set -l dir_preview (_get_dir_preview)
        echo (fd -0 --type d --hidden | fzf --read0 --preview $dir_preview --query "$argv")
    end

    function find-any
        set -l preview_cmd "test -d {} && $(_get_dir_preview) || $(_get_file_preview)"
        echo (fd -0 --hidden | fzf --read0 --preview $preview_cmd --query "$argv")
    end

    function find-url
        set -l input ""
        while read -lz line
            set -a input $line
        end

        set -l urls (string match -ar 'https?://[^\s]+' "$input")

        if test (count $urls) -gt 1
            string join \n $urls | fzf --query "$argv"
        else if test (count $urls) -eq 1
            echo $urls[1]
        end
    end

    function _find_change_directory -d "Change to selected directory"
        set -l selection (find-directory)
        if test -d "$selection"
            echo "cd $selection"
        end
    end

    function _find_edit_any -d "Find and edit anything"
        set -l selection (find-any)

        if test -d "$selection"
            echo "cd $selection && $EDITOR"
        else if test -f "$selection"
            echo "$EDITOR $selection"
        end
    end

    function _find_edit_file -d "Find and edit file"
        set -l selection (find-file)
        if test -f "$selection"
            echo "$EDITOR $selection"
        end
    end

    function _find_edit_directory -d "Find and edit directory"
        set -l selection (find-directory)
        if test -d "$selection"
            echo "cd $selection && $EDITOR"
        end
    end

    function _find_any_no_args
        find-any
    end
    function _find_file_no_args
        find-file
    end
    function _find_directory_no_args
        find-directory
    end

    abbr -a @fa --position anywhere --function _find_any_no_args
    abbr -a @fd --position anywhere --function _find_directory_no_args
    abbr -a @ff --position anywhere --function _find_file_no_args
    abbr -a @f --position anywhere "| fzf"
    abbr -a @yu --position anywhere "| find-url | yank"

    abbr fcd --function _find_change_directory
    abbr cf --function _find_change_directory

    abbr ed --function _find_edit_directory
    abbr ef --function _find_edit_file
    abbr ea --function _find_edit_any
end

if command -sq docker 
    function _find_docker_container_preview
        set -l lines 500;
        echo -e "\n\033[1;36m===== Container Logs (last $lines lines) =====\033[0m"; 
        docker logs --tail $lines $argv[1] 2>/dev/null || echo "No logs available";

        echo -e "\n\n\033[1;36m===== Container Info =====\033[0m";
        docker ps --no-trunc --format "{{json .}}" --filter id="$argv[1]" | jq -C .; 
    end

    function _find_docker_shell
        set -l container $(find-docker-container)
        if test -n "$container" 

            docker exec $container bash &> /dev/null
            if test $status -eq 0
                echo "docker exec -it $container bash"
            else 
                echo "docker exec -it $container sh"
            end
        end
    end

    function find-docker-container 
        echo $(
        docker ps \
        --filter status=running \
        --format "table {{.Names}}\t{{.Image}}\t{{.ID}}" \
        | \
        fzf \
        --header-lines=1 \
        --preview "$(functions _find_docker_container_preview); _find_docker_container_preview {3}" \
        --preview-window 'right,50%,follow' \
        --bind 'ctrl-r:reload(docker ps --filter status=running --format "table {{.Names}}\t{{.Image}}\t{{.ID}}")' \
        --bind 'enter:become(echo {3})' \
        --color header:italic \
        )
    end

    abbr dup 'docker compose up --build --force-recreate -v'
    abbr dub 'docker compose up --build --force-recreate -v'

    // TODO: Only enable for fzf
    abbr dsh --function _find_docker_shell

    abbr ddo 'docker compose down'
    abbr dkl 'docker kill $(docker ps -q)'
    abbr dkla 'docker kill $(docker ps -q)'
    abbr dcl 'docker system prune --volumes -f'
    abbr dcla 'docker system prune --volumes -f -a'
end

if command -sq git

    function _git_abbr
        set -l name $argv[1]
        set -l body $argv[2..-1]

        function _current_branch
            begin
                git symbolic-ref HEAD; or git rev-parse --short HEAD; or return
            end 2>/dev/null | sed -e 's|^refs/heads/||'
        end

        function _default_branch
            command git rev-parse --git-dir &>/dev/null; or return
            if set -l default_branch (command git config --get init.defaultBranch)
                and command git show-ref -q --verify refs/heads/{$default_branch}
                echo $default_branch
            else if command git show-ref -q --verify refs/heads/main
                echo main
            else
                echo master
            end
        end

        function _handle_git_abbr_$name --inherit-variable name --inherit-variable body
            set -l cmd (
                  echo $body \
                | string replace '{current_branch}' (_current_branch) \
                | string replace '{default_branch}' (_default_branch)
            )
            echo $cmd
        end

        abbr $name --function "_handle_git_abbr_$name"
    end

    _git_abbr g git
    _git_abbr ga git add
    _git_abbr gaa git add --all
    _git_abbr gc git commit -v
    _git_abbr gc! git commit -v --amend
    _git_abbr gca git commit -v -a
    _git_abbr gca! git commit -v -a --amend
    _git_abbr gcl git clone
    _git_abbr gd git diff
    _git_abbr gdca git diff --cached
    _git_abbr gdw git diff --word-diff
    _git_abbr gdwc git diff --word-diff --cached
    _git_abbr gf git fetch
    _git_abbr gfa git fetch --all --prune
    _git_abbr gl git pull
    _git_abbr ggl git pull origin {current_branch}
    _git_abbr gll git pull origin
    _git_abbr glr git pull --rebase
    _git_abbr gp git push
    _git_abbr gp! git push --force-with-lease
    _git_abbr gpo git push origin
    _git_abbr gpo! git push --force-with-lease origin
    _git_abbr gpv git push --no-verify
    _git_abbr gpv! git push --no-verify --force-with-lease
    _git_abbr ggp git push origin {current_branch}
    _git_abbr ggp! git push origin {current_branch} --force-with-lease
    _git_abbr gpu git push origin {current_branch} --set-upstream
    _git_abbr grbd git rebase develop
    _git_abbr grbdi git rebase develop --interactive
    _git_abbr grbdia git rebase develop --interactive --autosquash
    _git_abbr ggu git pull --rebase origin {current_branch}
    _git_abbr gs git status
    _git_abbr gsb git status -sb
    _git_abbr gss git status -s
    _git_abbr gsu git submodule update
    _git_abbr gsur git submodule update --recursive
    _git_abbr gsuri git submodule update --recursive --init
    _git_abbr gup git pull --rebase
    _git_abbr gupv git pull --rebase -v
    _git_abbr gupa git pull --rebase --autostash
    _git_abbr gupav git pull --rebase --autostash -v
    _git_abbr gco git checkout
    _git_abbr gcb git checkout -b
    _git_abbr gcod git checkout develop
    _git_abbr gcom git checkout {default_branch}

    alias cd-git 'git rev-parse 2>/dev/null && cd "$(git rev-parse --show-cdup)"'
    abbr cg cd-git
end

# Override ls with eza
if command -sq eza
    alias ls "eza --git --icons"
end

if command -sq nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else if command -sq vim
    set -gx EDITOR vim
    set -gx VISUAL vim
else if command -sq vi
    set -gx EDITOR vi
    set -gx VISUAL vi
end

abbr e "$EDITOR"
abbr edit "$EDITOR"
abbr vi "$EDITOR"
abbr vim "$EDITOR"
abbr svi "sudo $EDITOR"
abbr vis "$EDITOR '+set si'"
abbr nano "$EDITOR"
abbr emacs "$EDITOR"

# If possible use bottom
if command -sq btm
    abbr top btm
end

alias yank fish_clipboard_copy
alias paste fish_clipboard_paste

function _abbr_yank_line
    set -l current_line (commandline -b)
    set -l new_line (string replace $argv[1] "" $current_line)
    set -l new_line (string trim $new_line | string escape | string replace -a '"' '\\"')
    set -l new_line "echo $new_line | yank"

    # TODO: Verify :+2 and :+5 after release of https://github.com/fish-shell/fish-shell/issues/11324
    set -l pos (string match -n -r $argv[1] $current_line | string split " ")
    set -l replacement (string sub -s $pos[1] -l $pos[2] $new_line)

    commandline -r $new_line
    echo $replacement
end

function _abbr_paste
    paste
end

abbr -a @y --position anywhere "| yank"
abbr -a @yl --position anywhere --function _abbr_yank_line

abbr -a @p --position anywhere '$(paste)'
abbr -a @P --position anywhere --function _abbr_paste

abbr -a @e --position anywhere "| $EDITOR"
abbr -a @n --position anywhere "&>/dev/null"

if command -sq bat
    abbr -a @l --position anywhere "| bat"
else
    abbr -a @l --position anywhere "| less"
end
if command -sq rg
    abbr -a @g --position anywhere "| rg"
else
    abbr -a @g --position anywhere "| grep"
end

function _last_history_item
    echo (atuin-history 0)
end
abbr -a !! --position anywhere --function _last_history_item

function _last_history_item_sudo
    echo sudo (atuin-history 0)
end
abbr -a !!! --position anywhere --function _last_history_item_sudo

# Helper function that handles the common functionality
# function _abbr_transform_command
#     set -l transformer $argv[2]
#     set -l current_line (commandline -b)
#     set -l new_line (string replace $argv[1] "" $current_line)
#     set -l new_line (string trim $new_line)
#
#     # Apply transformation
#     if functions -q $transformer
#         set new_line ($transformer $new_line)
#     end
#
#     # TODO: Verify :+2 and :+5 after release of https://github.com/fish-shell/fish-shell/issues/11324
#     set -l pos (string match -n -r $argv[1] $current_line | string split " ")
#     set -l replacement (string sub -s $pos[1] -l $pos[2] $new_line)
#
#     commandline -r $new_line
#     echo $replacement
# end

# function _abbr_yank_line
#     # Define a unique function name using the calling function's name as prefix
#     set -l transformer "_transform_"(random)
#
#     function $transformer
#         set -l escaped_line (string escape $argv[1] | string replace -a "\"" "\\\"")
#         echo "echo $escaped_line | yank"
#
#         # Self-destruct after use
#         functions -e $transformer
#     end
#
#     _abbr_transform_command $argv[1] $transformer
# end
# abbr -a @yl --position anywhere --function _abbr_yank_line
#
# function _abbr_bash
#     # Define a unique function name using the calling function's name as prefix
#     set -l transformer "_transform_"(random)
#
#     function $transformer
#         set -l escaped_line (string escape $argv[1] | string replace -a "\"" "\\\"")
#         echo "bash -c $escaped_line"
#
#         # Self-destruct after use
#         functions -e $transformer
#     end
#
#     _abbr_transform_command $argv[1] $transformer
# end
# abbr -a @bash --position anywhere --function _abbr_bash
#
# function _abbr_time
#     # Define a unique function name using the calling function's name as prefix
#     set -l transformer "_transform_"(random)
#
#     function $transformer
#         echo "time begin $argv[1]; end"
#
#         # Self-destruct after use
#         functions -e $transformer
#     end
#
#     _abbr_transform_command $argv[1] $transformer
# end
# abbr -a @time --position anywhere --function _abbr_time
