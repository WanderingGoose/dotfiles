#!/bin/sh
#
# Starship
#
# This installs Starship.

# Check for Starship
if test ! $(which starship)
then
  echo "  Installing Starship for you."

  sh -c "$(curl -fsSL https://starship.rs/install.sh)"  -- -y

  ln -s $DOTFILES_ROOT/.config/starship.toml $HOME/config/starship.toml

fi

exit 0