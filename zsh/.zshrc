# The following lines were added by compinstall
zstyle :compinstall filename '/home/lohfu/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

function zshaddhistory() {
   if [[ $1 = "fgc"* ]] ; then
     return 1
   fi
}

setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt appendhistory notify
unsetopt autocd beep extendedglob nomatch

bindkey -e

DIRSTACKSIZE=8

setopt autopushd pushdminus pushdsilent pushdtohome

# Fish-like Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FZF 
FZF_CTRL_R_OPTS='--reverse'
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source $HOME/.zsh/fzf-git.zsh


# Autopairs
source $HOME/.zsh/autopair.zsh
source $HOME/.zsh/zsh-git-prompt.zsh

# Settings

# see https://superuser.com/questions/613685/how-stop-zsh-from-eating-space-before-pipe-symbol
ZLE_REMOVE_SUFFIX_CHARS=""

# see https://stackoverflow.com/questions/37772712/zsh-how-to-make-tab-completion-need-no-space-to-next-word-after-cursor
bindkey '^i' expand-or-complete-prefix

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=":"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[default]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%}%{X%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[red]%}%{%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]%}%{-%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"

autoload -U colors && colors

PS1='%{$fg[blue]%}┌ %{$fg[blue]%}%n%{$reset_color%}.%{$fg[green]%}%m%{$reset_color%} %{$fg[white]%}%~% %b $(git_super_status)
%{$fg[blue]%}└─ %{$reset_color%}'

# Alias > Misc

alias mb='touch "$(date +%Y%m%d_%H%M%S_%Z).md"'
alias mpdl='mpd ~/.config/mpd-lasse/mpd.conf'
alias pj='jq "."'
alias steam-wine=' WINEARCH=win32 wine ~/.wine/drive_c/Program\ Files/Steam/Steam.exe'
alias steamed='LD_PRELOAD="/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so" /usr/bin/steam'
alias mouse-left='xmodmap -e "pointer = 3 2 1"'
alias mouse-right='xmodmap -e "pointer = 1 2 3"'

# Alias > ZSH

alias ze='vim $HOME/.zshrc'
alias zs='source $HOME/.zshrc'

# Alias > System

alias grep='grep --color=auto'
alias ls='LC_ALL=C ls --color=auto' #LC_ALL=c sorts hidden files first (and is case insensitive, unfortunately)
alias vim='nvim'
alias xsel='xsel --logfile $HOME/.log/xsel.log'
alias ngrep='grep --exclude-dir=.git/ --exclude-dir node_modules/ -r'

# Alias > screen layouts

alias set-screens-bosse='xrandr --output DVI-I-1 --primary --auto --output DP-1 --left-of DVI-I-1 --auto --output DVI-D-0 --right-of DVI-I-1 --auto' 
alias set-screens-cybercom='xrandr --output DP1-2 --primary --auto --output DP1-1 --off --output eDP1 --auto --right-of DP1-2'
alias set-screens-laptop='xrandr --output DP1-1 --off --output DP1 --off --output DP1-2 --off --output eDP1 --auto'
alias set-screens-lou-lysvik='xrandr --output DP1-1 --auto --primary --output DP1-2 --off --output DP1-3 --auto --right-of DP1-1 --output eDP1 --off'
alias set-screens-lysvik='xrandr --output eDP1 --off --output HDMI1 --primary --left-of VGA1'

# Alias > SSH Mounting

alias sme='sshfs lohfu@loadmaster:/mnt/ext02/ebooks /mnt/ebooks'
alias smh='sshfs lohfu@loadmaster:/mnt/storage/lohfu /mnt/home'
alias smm-putte='sshfs lohfu@192.168.1.11:/mnt/storage/music /mnt/music'
alias smm='sshfs lohfu@loadmaster:/mnt/ext02/music /mnt/music'
alias smn='sshfs lohfu@loadmaster:/mnt/ext01/new /mnt/new'
alias smt='sshfs master@loadmaster:/mnt/torrents /mnt/torrents'
alias smtl='sshfs master@192.168.1.60:/mnt/torrents /mnt/torrents'

# Alias > Mining

alias mine-ether="ethminer -F http://ethereumpool.co/?miner=8@0xCfc5C04397832c5FFC9173cCe4144F5ec9fAC66D@boris"
alias mine-lyra="./build/ccminer/ccminer -a lyra2v2 -o stratum+tcp://lyra2rev2.eu.nicehash.com:3347 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"
alias mine-keccak="./build/ccminer/ccminer -a keccak -o stratum+tcp://keccak.eu.nicehash.com:3338 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"
alias mine-decred="./build/ccminer/ccminer -a decred -o stratum+tcp://decred.eu.nicehash.com:3354 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"
alias mine-nist5="./build/ccminer/ccminer -a nist5 -o stratum+tcp://nist5.eu.nicehash.com:3340 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.bror"
alias mine-cpu-cryptonight="cpuminer -a cryptonight -o stratum+tcp://cryptonight.eu.nicehash.com:3355 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"
alias mine-cpu-lyra2re="cpuminer -a lyra2re -o stratum+tcp://lyra2re.eu.nicehash.com:3342 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.bror"
alias mine-cpu-nist5="cpuminer -a nist5 -o stratum+tcp://nist5.eu.nicehash.com:3340 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"

# Alias > _sync

alias backup='$HOME/bin/sync -cfB'
alias restore='$HOME/bin/sync -cfR'

# Alias > NPM

alias ni='npm install'
alias nid='npm install --save-dev'
alias nis='npm install --save'
alias nr='npm run'
alias nu='npm uninstall'
alias nud='npm uninstall --save-dev'
alias nus='npm uninstall --save'
alias nU='npm update'

# Alias > Task

alias ta='task add'
alias tm='task modify'

# Alias > Git

alias gA='git add $_'
alias ga='git add'
alias gb='git branch'
alias gC='git checkout'
alias gc='git commit'
alias gca='git commit --amend'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch'
alias gl='git log'
alias gp='git push'
alias gR='git rebase'
alias gr='git reset'
alias gs='git status'

# Alias > shotwell

alias shotwell-ideas='shotwell -d $HOME/.local/share/shotwell-ideas'
alias shotwell-interesting='shotwell -d $HOME/.local/share/shotwell-interesting'
alias shotwell-lol='shotwell -d $HOME/.local/share/shotwell-lol'

# Alias > Mongo

alias msb='mongo mongo.bitmill.co/admin -u adminSupreme -p'
alias msl='mongo mongo.bitmill.co/liverpooltravel -u liverpooltravelSupreme -p'
alias msa='mongo mongo.bitmill.co/ams -u ams-supreme -p'
alias msn='mongo mongo.newseri.com/newseri -u newseri-supreme -p'
alias msp='mongo mongo.mypaper.io/mypaper-dev -u mypaper-supreme -p'
alias mspw='mongo mongo.mypaper.io/mypaper-website-dev -u mypaper-supreme -p'

pacman() { command pacman "$@" ; rehash ; }

jcurl() {
   curl -H "Accept: application/json" "$@" | jq '.'
}

# Neovim does not reset the terminal title on exits
# https://github.com/neovim/neovim/issues/7129
function precmd() {
   echo -en "\e]0;urxvt\a"
}


# see https://superuser.com/questions/410356/how-do-you-make-zsh-meta-delete-behave-like-bash-to-make-it-delete-a-word-inst
# other, not as simple solutions more in depth explanation at https://superuser.com/questions/410356/how-do-you-make-zsh-meta-delete-behave-like-bash-to-make-it-delete-a-word-inst
export WORDCHARS=''

# from grml
# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
#export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_so=$'\E[01;35m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# https://wiki.archlinux.org/index.php/Zsh#Configuring_.24PATH
export PATH="$HOME/bin:/$HOME/node_modules/.bin:$PATH"

