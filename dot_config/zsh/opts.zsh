# Enable colors
autoload -U colors && colors

# set zsh options
# setopt correct             # Turn on spelling correction
setopt histignoredups      # Don't save duplicates in command history
setopt noclobber           # Don't allow accidental file over-writes
setopt nobeep              # Disable beep
setopt chasedots           # Remove unnesseary directories. eg: './foo/bar/..' to './foo'
setopt pushd_ignore_dups   # Do not push the same directory multible times to the stack

# Neovim is the one and only editor
export EDITOR='nvim'
export DIFFPROG="nvim -d"