#!/bin/sh
#
# Rustup
#
# This installs Rustup and Rust.

# Check for Rustup

if test ! $(which rustup)
then
  echo "  Installing Rustup for you."

  sh -c "$(curl --proto '=http' --tlsv1.2 -sSL https://sh.rustup.rs)"  -- -y

  echo " Rustup installed"
else
  echo " Rustup already installed"
fi

exit 0