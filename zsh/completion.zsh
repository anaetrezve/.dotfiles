# if command -v ngrok &>/dev/null; then
#   eval "$(ngrok completion)"
# fi

# if type brew &>/dev/null; then
#     FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
#     autoload -Uz compinit
#     compinit
# fi

# Nvm completion
if [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ]; then 
  \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"; # This loads nvm bash_completion
fi
