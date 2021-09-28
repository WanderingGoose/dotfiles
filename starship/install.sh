#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which starship)
then
  echo "  Installing Starship for you."

  sh -c "$(curl -fsSL https://starship.rs/install.sh)"  -- -y

fi

exit 0