source ~/antigen.zsh
eval "$(fasd --init auto)"

antigen use oh-my-zsh

antigen theme eastwood

antigen bundle git
antigen bundle brew
antigen bundle bundler
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle rails
antigen bundle djui/alias-tips
antigen bundle git-flow

antigen apply

alias v='f -e vim'
alias o='a -e atom'
alias vim='mvim -v'

if [[ -e $HOME/.motd ]]; then cat $HOME/.motd; fi

function scap() { DEPLOY_ENV=staging cap $1 --set deploy_environment="staging" --set-before deploy_environment="staging" }

_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

ensure_tmux_is_running

