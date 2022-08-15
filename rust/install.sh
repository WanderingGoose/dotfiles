#!/bin/sh
#
# Rustup
#
# This installs Rustup and Rust.

# Check for Rustup
echo ""
echo "  ⚙️ Checking for Rustup ⚙️"

if test ! $(which rustup); then
  echo "    ⚙️ Installing Rustup for you."

  sh -c "$(curl --proto '=https' --tlsv1.2 -sSL https://sh.rustup.rs)" -- -y

  echo "    ⚙️ Rustup installed"
else
  rustup self update
  rustup update
  echo "    ⚙️ Rustup already installed"
fi

echo ""
exit 0
