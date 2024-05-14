#!/bin/bash

set -euo pipefail

PLUGIN_PATH=~/.local/share/tmux/plugins/

if [[ ! -x $(which tmux) ]]; then
  echo "Installing tmux, password required"
  set -x
  sudo apt install tmux
  set +x
fi

if [[ ! -d $PLUGIN_PATH ]]; then
  echo "Setting up TPM"
  set -x
  git clone https://github.com/tmux-plugins/tpm $PLUGIN_PATH
  set +x
fi

set -x
just stow tmux
set +x

echo "Finished"
