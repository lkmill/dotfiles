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
bindkey '^u' backward-kill-line

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

PS1='%{$fg[blue]%}┌ %{$fg[blue]%}%n%{$reset_color%}.%{$fg_bold[green]%}%m%{$reset_color%} %{$fg[white]%}%~% %b $(git_super_status)
%{$fg[blue]%}└─ %{$reset_color%}'

# Alias > Misc

alias mb='touch "$(date +%Y%m%d_%H%M%S_%Z).md"'
alias mpdl='mpd ~/.config/mpd-lasse/mpd.conf'
alias pj='jq "."'
alias steam-wine=' WINEARCH=win32 wine ~/.wine/drive_c/Program\ Files/Steam/Steam.exe'
alias steamed='LD_PRELOAD="/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so" /usr/bin/steam'
alias mouse-left='xmodmap -e "pointer = 3 2 1"'
alias mouse-right='xmodmap -e "pointer = 1 2 3"'
alias fchmod='find . -type f -exec chmod 644 {} \;'
alias dchmod='find . -type d -exec chmod 755 {} \;'

# Alias > ZSH

alias ze='vim $HOME/.zshrc'
alias zs='source $HOME/.zshrc'

# Alias > System

alias grep='grep --color=auto'
alias ls='LC_ALL=C ls -F --color=auto' #LC_ALL=c sorts hidden files first (and is case insensitive, unfortunately)
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

alias sme='sshfs lohfu@loader:/mnt/storage/ebooks /mnt/ebooks'
alias smen='sshfs lohfu@loader:/mnt/storage/ebooks-new /mnt/ebooks-new'
alias smh='sshfs lohfu@loader:/mnt/storage/lohfu /mnt/home'
alias smm-putte='sshfs lohfu@putte:/mnt/storage/music /mnt/music'
alias smm='sshfs lohfu@loader:/mnt/storage/music /mnt/music'
alias smm-i='sshfs lohfu@192.168.1.50:/mnt/storage/music /mnt/music'
alias smn='sshfs lohfu@loader:/mnt/storage/new /mnt/new'
alias smt='sshfs lohfu@loader:/mnt/torrents /mnt/torrents'

# Alias > Mining

alias mine-ether="ethminer -F http://ethereumpool.co/?miner=8@0xCfc5C04397832c5FFC9173cCe4144F5ec9fAC66D@boris"
alias mine-lyra="./build/ccminer/ccminer -a lyra2v2 -o stratum+tcp://lyra2rev2.eu.nicehash.com:3347 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"
alias mine-keccak="./build/ccminer/ccminer -a keccak -o stratum+tcp://keccak.eu.nicehash.com:3338 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"
alias mine-decred="./build/ccminer/ccminer -a decred -o stratum+tcp://decred.eu.nicehash.com:3354 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"
alias mine-nist5="./build/ccminer/ccminer -a nist5 -o stratum+tcp://nist5.eu.nicehash.com:3340 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.bror"
alias mine-cpu-cryptonight="cpuminer -a cryptonight -o stratum+tcp://cryptonight.eu.nicehash.com:3355 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"
alias mine-cpu-lyra2re="cpuminer -a lyra2re -o stratum+tcp://lyra2re.eu.nicehash.com:3342 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.bror"
alias mine-cpu-nist5="cpuminer -a nist5 -o stratum+tcp://nist5.eu.nicehash.com:3340 -u 1ARxGXvJwHYUVqmTNPAHUjHFNbERf8Dzi.boris"

# Alias > NPM, yarn

alias ni='npm install'
alias nid='npm install --save-dev'
alias nis='npm install --save'
alias nr='npm run'
alias nu='npm uninstall'
alias nud='npm uninstall --save-dev'
alias nus='npm uninstall --save'
alias nU='npm update'

alias yr='yarn run'
alias yi='yarn add'

# Alias > Task

alias ta='task add'
alias tm='task modify'

# Alias > Git

alias g='git'
alias gA='git add $_'
alias ga='git add'
alias gai='git add -i'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbl='git branch -l'
alias gbla='git branch -la'
alias gblr='git branch -lr'
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
alias gsa='git stash apply'
alias gsl='git stash list'
alias gsp='git stash push'
alias gsP='git stash pop'
alias gss='git stash show'

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

# functions > sync

backup() {
  sync.py -B "$@"
}

restore() {
  sync.py -R "$@"
}

# functions > misc

pacman() { command pacman "$@" ; rehash ; }

jcurl() {
   curl -H "Accept: application/json" "$@" | jq '.'
}

# Neovim does not reset the terminal title on exits
# https://github.com/neovim/neovim/issues/7129
function precmd() {
   echo -en "\e]0;urxvt\a"
}

export PASSWORD_STORE_X_SELECTION=primary

# see https://superuser.com/questions/410356/how-do-you-make-zsh-meta-delete-behave-like-bash-to-make-it-delete-a-word-inst
# other, not as simple solutions more in depth explanation at https://superuser.com/questions/410356/how-do-you-make-zsh-meta-delete-behave-like-bash-to-make-it-delete-a-word-inst
export WORDCHARS=''
