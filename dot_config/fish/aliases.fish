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

alias cg 'git rev-parse && cd "$(git rev-parse --show-cdup)"'
alias cdg cg

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

if command -sq btm
    alias top "btm"
end

#