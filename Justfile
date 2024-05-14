sauce_code_pro := "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/SourceCodePro.zip"

dev-env: font zsh tmux nvim

font:
  @echo "Setting up fonts..."
  curl -fLo "dist/SauceCodePro.zip" {{ sauce_code_pro }}
  mkdir -p ~/.local/share/fonts/SauceCodePro
  mkdir dist
  unzip dist/SauceCodePro.zip -d ~/.local/share/fonts/SauceCodePro

stow tool:
  stow --dotfiles --restow --target=$HOME {{tool}}
  
zsh:
  @echo "Setting up ZSH..."
  bash ./scripts/install_zsh.sh

tmux:
  @echo "Setting up tmux"
  bash ./scripts/install_tmux.sh

nvim:
  @echo "Setting up nvim"
  bash ./scripts/install_nvim.sh
  just stow nvim

clean:
  rm -r dist/
