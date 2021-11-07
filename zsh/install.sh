#!/bin/bash

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
