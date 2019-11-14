# Environment Variables

export PATH="$(du -L "$HOME/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//'):$HOME/bin:/$HOME/node_modules/.bin:$PATH"
export EDITOR="nvim"
export TERMINAL="urxvt"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"

# from grml
# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;35m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

