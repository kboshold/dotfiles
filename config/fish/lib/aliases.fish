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

    function select-file
        set -l file_preview (_get_file_preview)
        echo (fd -0 --type f --hidden | fzf --read0 --preview $file_preview --query "$argv")
    end

    function select-directory 
        set -l dir_preview (_get_dir_preview)
        echo (fd -0 --type d --hidden | fzf --read0 --preview $dir_preview --query "$argv")
    end
    
    function select-any
        set -l preview_cmd "test -d {} && $(_get_dir_preview) || $(_get_file_preview)"
        echo (fd -0 --hidden | fzf --read0 --preview $preview_cmd --query "$argv")
    end

    function cdf -d "Change to selected directory"
        set -l directory (select-directory)
        test -n "$directory" && cd "$directory"
    end
    alias cf cdf

    function ef -d "Change to directory and edit file or current directory"
        set -l selection (select-any)

        if test -d "$selection"
            cd "$selection"
            $EDITOR
        else if test -f "$selection"
            $EDITOR "$selection"
        end
    end

    function _select_any_no_args 
        select-any
    end
    function _select_file_no_args 
        select-file
    end
    function _select_directory_no_args 
        select-directory
    end

    abbr -a @sa --position anywhere --function _select_any_no_args
    abbr -a @sd --position anywhere --function _select_directory_no_args
    abbr -a @sf --position anywhere --function _select_file_no_args

end

if command -sq git

    function _git_abbr
        set -l name $argv[1]
        set -l body $argv[2..-1]

        function _current_branch
            begin
                git symbolic-ref HEAD; or \
                git rev-parse --short HEAD; or return
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

    _git_abbr g          git
    _git_abbr ga         git add
    _git_abbr gaa        git add --all
    _git_abbr gc         git commit -v
    _git_abbr gc!        git commit -v --amend
    _git_abbr gca        git commit -v -a
    _git_abbr gca!       git commit -v -a --amend
    _git_abbr gcl        git clone
    _git_abbr gd         git diff
    _git_abbr gdca       git diff --cached
    _git_abbr gdw        git diff --word-diff
    _git_abbr gdwc       git diff --word-diff --cached
    _git_abbr gf         git fetch
    _git_abbr gfa        git fetch --all --prune
    _git_abbr gl         git pull
    _git_abbr ggl        git pull origin {current_branch}
    _git_abbr gll        git pull origin
    _git_abbr glr        git pull --rebase
    _git_abbr gp         git push
    _git_abbr gp!        git push --force-with-lease
    _git_abbr gpo        git push origin
    _git_abbr gpo!       git push --force-with-lease origin
    _git_abbr gpv        git push --no-verify
    _git_abbr gpv!       git push --no-verify --force-with-lease
    _git_abbr ggp        git push origin {current_branch}
    _git_abbr ggp!       git push origin {current_branch} --force-with-lease
    _git_abbr gpu        git push origin {current_branch} --set-upstream
    _git_abbr grbd       git rebase develop
    _git_abbr grbdi      git rebase develop --interactive
    _git_abbr grbdia     git rebase develop --interactive --autosquash
    _git_abbr ggu        git pull --rebase origin {current_branch}
    _git_abbr gs         git status
    _git_abbr gsb        git status -sb
    _git_abbr gss        git status -s
    _git_abbr gsu        git submodule update
    _git_abbr gsur       git submodule update --recursive
    _git_abbr gsuri      git submodule update --recursive --init
    _git_abbr gup        git pull --rebase
    _git_abbr gupv       git pull --rebase -v
    _git_abbr gupa       git pull --rebase --autostash
    _git_abbr gupav      git pull --rebase --autostash -v
    _git_abbr gco        git checkout
    _git_abbr gcb        git checkout -b
    _git_abbr gcod       git checkout develop
    _git_abbr gcom       git checkout {default_branch}

    alias cd-git 'git rev-parse 2>/dev/null && cd "$(git rev-parse --show-cdup)"'
    abbr cg "cd-git"
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
    abbr top "btm"
end

abbr -a @y --position anywhere "| fish_clipboard_copy"
abbr -a @p --position anywhere "fish_clipboard_paste"

if command -sq bat
    abbr -a @l --position anywhere "| bat"
else
    abbr -a @l --position anywhere "| less"
end 
abbr -a @e --position anywhere "| $EDITOR"
