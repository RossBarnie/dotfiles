#!/bin/bash

set -euo pipefail

if [[ ! -x $(which nvim) ]]; then
  echo "Neovim already installed, skipping..."
  exit 0
fi

NEOVIM_PREFIX="$HOME"/projects/neovim

if [[ ! -d $NEOVIM_PREFIX ]]; then
  git clone https://github.com/neovim/neovim "$NEOVIM_PREFIX"
fi

pushd "$NEOVIM_PREFIX"
git checkout "release-0.9"
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NEOVIM_PREFIX"
make install
popd

