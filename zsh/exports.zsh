#!/bin/sh

# history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=$HOME/.cashe/zsh/.zsh_history

export KEYTIMEOUT=1
export EDITOR=vim
export MANPAGER='nvim +Man!'
export MANWIDTH=999
# PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOMEBREW_PREFIX/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH="$HOME/.local/share/neovim/bin":$PATH
export PATH="$HOME/.local/share/bob/nvim-bin":$PATH
export PATH=$XDG_DATA_HOME/npm/bin:$PATH

export DOTFILES="$HOME/.dotfiles"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"; # This loads nvm

# Below line if we install nvm using curl or other command
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

