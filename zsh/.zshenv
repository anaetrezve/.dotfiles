# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# ZSH Paths
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
export ZSH=$XDG_CONFIG_HOME/zsh

# Go
export GOPATH=$XDG_CONFIG_HOME/go

# npm
# see npm config ls -l | grep /
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm

# Z
export _Z_DATA=$XDG_DATA_HOME/z

export TERM='xterm-256color'

eval "$(/opt/homebrew/bin/brew shellenv)"
