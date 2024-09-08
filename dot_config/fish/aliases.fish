# typos
alias clr clear
alias dc cd
alias sl ls
alias pdw pwd
alias dir ls


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

if command -sq fd
    function cdf 
        set -l directory (fd -0 --type d --hidden | fzf --read0)
        if test -n "$directory"
            cd $directory
        end
    end

    alias cf cdf
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
set -gx VISUAL vim

# If possible use neovim
if command -sq nvim
    alias vim "nvim"
end

# If possible use bottom
if command -sq btm
    alias top "btm"
end

#