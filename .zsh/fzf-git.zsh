__fzf_git_branch() {
  local branches branch

  while getopts "-ral" opt; do
    case $opt in
      "r")
        branches=$(git branch --remote | rg -v HEAD)
        branch=$(echo "$branches" | fzf +m | sed "s#[^/]*/##")
        ;;
      "a")
        branches=$(git branch --all | rg -v HEAD)
        branch=$(echo "$branches" | fzf +m | sed "s#remotes/[^/]*/##")
        ;;
    esac
  done

  if [ -z "$branch" ]; then
    branches=$(git branch)
    branch=$(echo "$branches" | fzf +m)
  fi

  branch=$(echo "$branch" | sed "s/.* //")

  echo $branch
}


fzf_branch_widget() {
  LBUFFER="${LBUFFER}$(__fzf_git_branch -l)"

  local ret=$?

  zle redisplay

  return $ret
}

fzf_branch_remote_widget() {
  LBUFFER="${LBUFFER}$(__fzf_git_branch -r)"

  local ret=$?

  zle redisplay

  return $ret
}

fzf_branch_all_widget() {
  LBUFFER="${LBUFFER}$(__fzf_git_branch -a)"

  local ret=$?

  zle redisplay

  return $ret
}

zle     -N   fzf_branch_widget
zle     -N   fzf_branch_remote_widget
zle     -N   fzf_branch_all_widget

bindkey '^Ob' fzf_branch_widget
bindkey '^O^B' fzf_branch_widget
bindkey '^Obl' fzf_branch_widget
bindkey '^O^B^L' fzf_branch_widget
bindkey '^Obr' fzf_branch_remote_widget
bindkey '^O^B^R' fzf_branch_remote_widget
bindkey '^Oba' fzf_branch_all_widget
bindkey '^O^B^A' fzf_branch_all_widget

bindkey '^O^F' fzf-file-widget

# checkout a local branch
fgc() {
  local cmd="git checkout $(__fzf_git_branch)"

  eval $cmd

  print -Sr ${cmd}
}


# checkout any branch
fgca() {
  local cmd="git checkout $(__fzf_git_branch -a)"

  eval $cmd

  print -Sr ${cmd}
}

# checkout a remote branch
fgcr() {
  local cmd="git checkout $(__fzf_git_branch -r)"

  eval $cmd

  print -Sr ${cmd}
}

# merge with a local branch
fgm() {
  local cmd="git merge $(__fzf_git_branch)"

  eval $cmd

  print -Sr ${cmd}
}

# rebase againts a local branch
fgr() {
  local cmd="git rebase $(__fzf_git_branch)"

  eval $cmd

  print -Sr ${cmd}
}


# example usage: git rebase -i `fcs`
# fcs - get git commit sha
__fzf_git_commit() {
  local branch branches commits commit

  while getopts "-rl" opt; do
    case $opt in
      "r")
         branch="$(__fzf_git_branch -r)"
         ;;
      "l")
         branch="$(__fzf_git_branch -l)"
         ;;
    esac
  done

  if [ -z "$branch" ]; then
     branch=$(git rev-parse --abbrev-ref HEAD)
  fi


  branch=$(echo "$branch" | sed "s/.* //")

  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse "$branch" --) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&

  echo -n $(echo "$commit" | sed "s/ .*//")
}

fzf_commit_current_branch_widget() {
  LBUFFER="${LBUFFER}$(__fzf_git_commit -b)"

  local ret=$?

  zle redisplay

  return $ret
}

fzf_commit_local_branches_widget() {
  LBUFFER="${LBUFFER}$(__fzf_git_commit -l)"

  local ret=$?

  zle redisplay

  return $ret
}

fzf_commit_remote_branches_widget() {
  LBUFFER="${LBUFFER}$(__fzf_git_commit -r)"

  local ret=$?

  zle redisplay

  return $ret
}

zle     -N   fzf_commit_current_branch_widget
zle     -N   fzf_commit_local_branches_widget
zle     -N   fzf_commit_remote_branches_widget

bindkey '^Oc' fzf_commit_current_branch_widget
bindkey '^Ocb' fzf_commit_current_branch_widget
bindkey '^Ocl' fzf_commit_local_branches_widget
bindkey '^Ocr' fzf_commit_remote_branches_widget

## FZF search through chromium history
fw() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  google_history="$HOME/.config/chromium/Default/History"
  open=xdg-open
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
      "select substr(title, 1, $cols), url
  from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}
