# If not running interactively, dont do anything
[[ $- != *i* ]] && return

export ZSH_CONFIG_HOME=$HOME/.config/zsh
export ZSH_PLUGIN_HOME=$HOME/.config/zsh/plugins

source $ZSH_CONFIG_HOME/opts.zsh
source $ZSH_CONFIG_HOME/aliases.zsh

export PATH=$PATH:$HOME/.local/bin:/opt/nvim/bin

# Better PS1
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
elif command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.json)"
fi

# Add version manager
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

# Add zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# Add atuin
if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh)"
    eval "$(atuin gen-completions --shell zsh)"
fi

source $ZSH_PLUGIN_HOME/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZSH_PLUGIN_HOME/zsh-completions/zsh-completions.plugin.zsh
source $ZSH_PLUGIN_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZSH_PLUGIN_HOME/zsh-vi-mode/zsh-vi-mode.plugin.zsh