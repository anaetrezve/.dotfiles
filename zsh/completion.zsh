if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi
