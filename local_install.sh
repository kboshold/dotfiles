#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mv $HOME/.bashrc $HOME/.bashrc.bak
ln -s $SCRIPT_DIR/dot_bashrc $HOME/.bashrc
mv   $HOME/.zshrc $HOME/.zshrc.bak
ln -s $SCRIPT_DIR/dot_zshrc $HOME/.zshrc
mv   $HOME/.rgignore $HOME/.rgignore.bak
ln -s $SCRIPT_DIR/dot_rgignore $HOME/.rgignore
mv   $HOME/.fdignore $HOME/.fdignore.bak
ln -s $SCRIPT_DIR/dot_fdignore $HOME/.fdignore

mv   $HOME/.config/nvim $HOME/.config/nvim.bak
ln -s $SCRIPT_DIR/dot_config/nvim $HOME/.config/nvim
mv   $HOME/.config/mise $HOME/.config/mise.bak
ln -s $SCRIPT_DIR/dot_config/mise $HOME/.config/mise
mv   $HOME/.config/fish $HOME/.config/fish.bak
ln -s $SCRIPT_DIR/dot_config/fish $HOME/.config/fish
mv   $HOME/.config/atuin $HOME/.config/atuin.bak
ln -s $SCRIPT_DIR/dot_config/atuin $HOME/.config/atuin
mv   $HOME/.config/nushell $HOME/.config/nushell.bak
ln -s $SCRIPT_DIR/dot_config/nushell $HOME/.config/nushell
mv   $HOME/.config/eza $HOME/.config/eza.bak
ln -s $SCRIPT_DIR/dot_config/eza $HOME/.config/eza
mv   $HOME/.config/zellij $HOME/.config/zellij.bak
ln -s $SCRIPT_DIR/dot_config/zellij $HOME/.config/zellij
mv   $HOME/.config/zsh $HOME/.config/zsh.bak
ln -s $SCRIPT_DIR/dot_config/zsh $HOME/.config/zsh
mv   $HOME/.config/starship.toml $HOME/.config/starship.toml.bak
ln -s $SCRIPT_DIR/dot_config/starship.toml $HOME/.config/starship.toml

