#!/bin/bash

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh is already installed"
else
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "oh-my-zsh installed"
fi

cd $HOME/.oh-my-zsh/custom/plugins

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  echo "zsh autosuggestions installed already"
else
  echo "Installing zsh autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git
  echo "zsh autosuggestions installed"
fi

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  echo "Zsh syntax highlighting installed already"
else
  echo "Installing zsh syntax highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  echo "zsh syntax highlighting installed"
fi

exit 0
