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

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

eval "$(zoxide init zsh)"

