export VISUAL='mvim -v'
export EDITOR='$VISUAL'

export PATH="$HOME/.bin:$HOME/.rbenv/bin:/usr/local/bin:$HOME/.rbenv/shims:$PATH"

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - zsh --no-rehash)"
fi
