source ~/antigen.zsh
if which fasd &>/dev/null ; then
  eval "$(fasd --init auto)"
fi
# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash zsh)"
fi

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

alias vim='nvim'
alias shipit='bundle exec cap production deploy'
