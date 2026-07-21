if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
  source /usr/share/cachyos-fish-config/cachyos-config.fish
end

# overwrite greeting
function fish_greeting
end

set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/rg/.ripgreprc

set -x EDITOR nvim
set -x VISUAL nvim

if test -x $(which zoxide)
  zoxide init fish | source
end

if test -x $(which direnv)
  direnv hook fish | source
end

if test -x $(which mise)
  mise activate fish | source
end
