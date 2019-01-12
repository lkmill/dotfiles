#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# hmmm. cant remember what this is for. think it has something to do with
# setting terminal window title
ssh_fnc() {
	echo -ne "\033]0;${@: -1}\007"
	ssh $@
}

alias set-screens-lysik='xrandr --output eDP-1 --off --output HDMI-1 --primary --left-of VGA-1'
alias ls='ls --color=auto'
alias vim='nvim'
alias jcurl='curl -H "Content-type: application/json"'
alias ssh=ssh_fnc
alias msl='mongo mongo.thecodebureau.com/liverpooltravel -u liverpooltravelSupreme -p'
PS1='[\[\e[1;34m\]\u\[\e[0m\]@\[\e[34m\]\h\[\e[0m\] \[\e[1;32m\]\W\[\e[0m\]]\$ \[\033]2;\h:\W\007\]'
export PATH="$HOME/bin:/$HOME/node_modules/.bin:$PATH"
export EDITOR=/usr/bin/vim
