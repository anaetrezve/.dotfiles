#!/bin/sh

alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias nvimrc='nvim ~/.config/nvim/'
alias nman='bob'
# alias lvim="env TERM=wezterm lvim"
# alias nvim="env TERM=wezterm nvim"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
# alias cp="cp -i"
# alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"

# general
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias la="ls -al --all"
alias ll="ls -l"
alias tree="eza -T --color=always --icons=always -I \".git|node_modules\""
alias vi="nvim"
alias vim="nvim"
alias cd="z"

# MongoDB and Docker aliases
alias localMongo="docker run -p 27017:27017 --name localMongo mongo:6.0.2-focal"
alias localMongoBG="docker run -d -p 27017:27017 --name localMongo mongo:6.0.2-focal"
alias localMongoStart="docker container start localMongo"
alias localMongoStop="docker container stop localMongo"

# PostgreSQL and Docker aliases
alias localPostgres="docker run --name localPostgres -p 5432:5432 -e POSTGRES_USER=user -e POSTGRES_PASSWORD=pass postgres:15.1-alpine"
alias localPostgresBG="docker run --name localPostgres -p 5432:5432 -e POSTGRES_USER=user -e POSTGRES_PASSWORD=pass -d postgres:15.1-alpine"
alias localPostgresStart="docker container start localPostgres"
alias localPostgresStop="docker container stop localPostgres"

# Directory Shortcut aliases
alias leetcodeGo="cd $HOME/Experiments/DSA/leetcode/golang"

alias dotfiles="cd $HOME/.dotfiles/"

