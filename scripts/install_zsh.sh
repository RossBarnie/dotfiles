#!/bin/bash

set -euo pipefail

zsh_path=$(which zsh)

if [[ ! -x $zsh_path ]]; then
  echo "Installing zsh"
  sudo apt install zsh
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing oh-my-zsh"
  # Probably not the best idea...
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc 'no'
  rm ~/.zshrc
fi

echo "Configuring zsh"
just stow zsh

echo "Changing default shell"
if [[ "$SHELL" != "$zsh_path" ]]; then
  chsh -s "$zsh_path"
fi

