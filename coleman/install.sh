#!/bin/sh
#
# Coleman
#
# This installs Coleman.
echo "🧞‍♂️"
echo "  🧞‍♂️ Checking for Coleman 🧞‍♂️"

# Check for Coleman
if test ! $(which coleman); then
  echo "    Installing 🧞‍♂️ Coleman for you."

  if [ -d "$HOME/source/personal/coleman" ]; then
    echo "        Coleman source directory already exists"
  else
    echo "           creating Coleman source directory"
    if [ -d "$HOME/source/personal" ]; then
      cd "$HOME/source/personal"
    else 
      mkdir -p "$HOME/source/personal"
      cd "$HOME/source/personal"
    fi
    
    git clone git@github.com:alecwhittington/coleman.git
    echo "        Coleman source directory created"
  fi

  if [ -d "$HOME/.coleman" ]; then
    echo "        Coleman config directory already exists"
  else
    echo "        Coleman config directory created"
    mkdir ~/.coleman
  fi

  if [ -d "$HOME/.coleman/coleman.config.yaml" ]; then
    echo "Coleman Config installed already"
  else
    echo "Installing Coleman Config"
    cp $DOTFILES_ROOT/.coleman/coleman.config.yaml $HOME/.coleman/coleman.config.yaml
    echo "Coleman Config installed"
  fi

  if [ -d "$HOME/.coleman/coleman.workspace.yaml" ]; then
    echo "Coleman Workspace installed already"
  else
    echo "Installing Coleman Workspace"
    cp $DOTFILES_ROOT/.coleman/coleman.workspace.yaml $HOME/.coleman/coleman.workspace.yaml
    echo "Coleman Workspace installed"
  fi

else

  echo "    🧞‍♂️ Coleman already installed"
fi

echo ""
exit 0
