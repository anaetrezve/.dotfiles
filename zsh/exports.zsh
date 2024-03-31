#!/bin/sh

# history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=$HOME/.cashe/zsh/.zsh_history

export KEYTIMEOUT=1
export EDITOR=vim
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOMEBREW_PREFIX/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH="$HOME/.local/share/neovim/bin":$PATH
export PATH="$HOME/.local/share/bob/nvim-bin":$PATH

export DOTFILES="$HOME/.dotfiles"

eval "$(zoxide init zsh)"

