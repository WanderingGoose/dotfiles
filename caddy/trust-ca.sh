#!/usr/bin/env bash
# Install shared mkcert CA on a new machine
# Part of Captain Goose's dotfiles system

set -e

DOTFILES_CA="$HOME/.dotfiles/caddy/certs/rootCA.pem"
MACHINE_NAME=$(scutil --get ComputerName 2>/dev/null || hostname)

echo "🏴‍☠️ Installing shared CA on $MACHINE_NAME..."
echo ""

# Check for dotfiles CA certificate
if [[ ! -f "$DOTFILES_CA" ]]; then
  echo "❌ ERROR: CA certificate not found at $DOTFILES_CA"
  echo ""
  echo "This file should be committed to your dotfiles repository."
  echo "On your primary machine, run:"
  echo "  cp \$(mkcert -CAROOT)/rootCA.pem ~/.dotfiles/caddy/certs/"
  echo "  cd ~/.dotfiles && git add caddy/certs/rootCA.pem && git commit && git push"
  echo ""
  exit 1
fi

# Check for mkcert
if ! command -v mkcert &>/dev/null; then
  echo "📦 Installing mkcert..."
  brew install mkcert
fi

# Set CAROOT to dotfiles location temporarily
CAROOT=$(mkcert -CAROOT)
echo "📁 Current CAROOT: $CAROOT"

# Copy shared CA to CAROOT if it doesn't exist
if [[ ! -f "$CAROOT/rootCA.pem" ]]; then
  echo "📋 Copying shared CA certificate to $CAROOT..."
  mkdir -p "$CAROOT"
  cp "$DOTFILES_CA" "$CAROOT/rootCA.pem"
fi

# Install to system trust store
echo "🔐 Installing CA to system trust store..."
mkcert -install

echo ""
echo "✅ Shared CA installed successfully!"
echo ""
echo "The following domains will now be trusted on this machine:"
echo "  - https://*.dsas.local"
echo "  - https://dsas.local"
echo "  - https://localhost"
echo ""
echo "Next steps:"
echo "  1. Generate local certificates: ~/.dotfiles/caddy/setup.sh"
echo "  2. Apply templates: dotman template apply"
echo ""
