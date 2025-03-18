# typos
alias clr clear
alias dc cd
alias sl ls
alias pdw pwd
alias dir ls
alias q exit

# Set up to 9 level of cd
set dots ""
set levels ""
for i in (seq 1 9)
	set dots ".$dots"
	set levels "../$levels"

	alias ".$i" "cd $levels"
	alias ".$dots" "cd $levels"
	alias "cd.$dots" "cd $levels"
	alias "cd$i" "cd $levels"
end

alias cg 'git rev-parse 2>/dev/null && cd "$(git rev-parse --show-cdup)"'
alias cdg cg

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

    function cdf -d "Change to selected directory"
        set -l dir_preview (_get_dir_preview)
        set -l directory (fd -0 --type d --hidden | fzf --read0 --preview $dir_preview --query "$argv")
        test -n "$directory" && cd "$directory"
    end
    alias cf cdf

    function ef -d "Change to directory and edit file or current directory"
        set -l preview_cmd "test -d {} && $(_get_dir_preview) || $(_get_file_preview)"
        set -l selection (fd -0 --hidden | fzf --read0 --preview $preview_cmd --query "$argv")

        if test -d "$selection"
            cd "$selection"
            $EDITOR
        else if test -f "$selection"
            $EDITOR "$selection"
        end
    end

end


# Override ls with eza
if command -sq eza
	alias ls "eza --git --icons"
end

# Use vim as default
alias e 'vim'
alias vi "vim"
alias svi 'sudo vi'
alias vis 'vim "+set si"'
alias edit 'vim'
alias nano 'vim'
alias emacs 'vim'

set -gx EDITOR vim
set -gx GIT_EDITOR vim
set -gx VISUAL vim

# If possible use neovim
if command -sq nvim
	alias vim "nvim"

	set -gx EDITOR nvim
	set -gx GIT_EDITOR nvim
	set -gx VISUAL nvim
end

# If possible use bottom
if command -sq btm
	alias top "btm"
end
