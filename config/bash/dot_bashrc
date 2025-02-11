export PATH="$PATH:$HOME/.local/bin:/opt/nvim/bin"
source "$HOME/.cargo/env"

if command -v mise &> /dev/null; then
    eval "$(mise activate bash)"
    eval "$(mise env -s bash)"
fi

# If not running interactively, dont do anything
[[ $- != *i* ]] && return

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#cba6f7,info:#b4befe,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#89dceb,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a --color=border:#b4befe \
--multi";

# Check if zellij or tmux should be used as terminal mutiplexer
if [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ -z "$ZELLIJ" ]; then
	# Use Tmux
  if command -v tmux &> /dev/null; then
	  exec tmux new-session -A -s main
  fi


  # Use Zellij over tmux if possible
  ZELLIJ_AUTO_ATTACH=true
  if command -v zellij &> /dev/null; then
	  if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
		  zellij attach -c main && exit
	  else
		  zellij && exit
	  fi
  fi

fi


# Start starship
if command -v starship &> /dev/null; then
	eval "$(starship init bash)"
fi
# eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.json)"
