source ~/antigen.zsh
if which fasd &>/dev/null ; then
  eval "$(fasd --init auto)"
fi
# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash zsh)"
fi

# load secrets
if [[ -f ~/.zsh/secretenv ]]; then
  source ~/.zsh/secretenv
fi

_echoerr () {
  echo $1 >&2
}

_find_project_dir () {
  if [[ -z "$1" ]]; then
    _echoerr "Must specify project name"
    return 1
  fi
  find ~/Websites -type d -maxdepth 2 -name $1
  return 0
}

cd_project () {
  dir=$( _find_project_dir $1 )
  if [[ -d $dir ]]; then
    cd $dir
  else
    _echoerr "Project not found"
    return 1
  fi
}

which_server () {
  if [[ -z "$1" ]]; then
    project_dir=$( pwd )
  else
    project_dir=$( _find_project_dir $1 )
  fi
  if [[ -a $project_dir/config/deploy.rb ]]; then
    grep "^set\ :tictoc_server,\ .*$" $project_dir/config/deploy.rb | cut -d \" -f 2
    return 0
  else
    _echoerr "Project not found"
    return 1
  fi
}

antigen use oh-my-zsh

antigen theme eastwood

antigen bundle git
antigen bundle bundler
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle rails
antigen bundle djui/alias-tips
antigen bundle git-flow

antigen apply

alias vim='nvim'
alias shipit='bundle exec cap production deploy'
alias caprod='bundle exec cap production'
alias ws='which_server'
alias cdp='cd_project'
