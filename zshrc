source ~/antigen.zsh
export PATH="$HOME/.rbenv/bin:/usr/local/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init - zsh --no-rehash)"
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

export VISUAL='mvim -v'
export EDITOR='$VISUAL'
