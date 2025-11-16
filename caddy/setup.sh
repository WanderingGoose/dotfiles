#!/usr/bin/env bash
# Caddy HTTPS setup with mkcert
# Part of Captain Goose's dotfiles system

set -e

echo "🏴‍☠️ Setting up Caddy HTTPS for local development..."
echo ""

# Check for mkcert
if ! command -v mkcert &>/dev/null; then
  echo "📦 Installing mkcert..."
  brew install mkcert
else
  echo "✅ mkcert is already installed"
fi

# Setup CA if needed
CAROOT=$(mkcert -CAROOT)
if [[ ! -f "$CAROOT/rootCA.pem" ]]; then
  echo ""
  echo "🔐 Creating mkcert Certificate Authority..."
  mkcert -install
  echo "✅ CA created and installed to system trust store"
else
  echo "✅ mkcert CA already exists"
fi

# Generate site certificates
CERT_DIR="$HOME/.caddy/certs"
mkdir -p "$CERT_DIR"

echo ""
if [[ ! -f "$CERT_DIR/_wildcard.dsas.local+4.pem" ]]; then
  echo "📜 Generating wildcard certificate for *.dsas.local..."
  cd "$CERT_DIR"
  mkcert "*.dsas.local" "dsas.local" "localhost" "127.0.0.1" "::1"
  echo "✅ Certificate generated: $CERT_DIR/_wildcard.dsas.local+4.pem"
else
  echo "✅ Wildcard certificate already exists"
  echo "   Location: $CERT_DIR/_wildcard.dsas.local+4.pem"
fi

# Setup Node.js trust
echo ""
if ! grep -q "NODE_EXTRA_CA_CERTS" "$HOME/.zshrc" 2>/dev/null; then
  echo "🔧 Adding NODE_EXTRA_CA_CERTS to ~/.zshrc..."
  echo '' >> "$HOME/.zshrc"
  echo '# Trust mkcert CA for Node.js apps' >> "$HOME/.zshrc"
  echo 'export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"' >> "$HOME/.zshrc"
  echo "✅ Added NODE_EXTRA_CA_CERTS to ~/.zshrc"
  echo "   Restart your terminal or run: source ~/.zshrc"
else
  echo "✅ NODE_EXTRA_CA_CERTS already configured"
fi

echo ""
echo "🎉 HTTPS setup complete!"
echo ""
echo "Certificates:"
echo "  - Wildcard cert: $CERT_DIR/_wildcard.dsas.local+4.pem"
echo "  - Private key: $CERT_DIR/_wildcard.dsas.local+4-key.pem"
echo "  - Valid until: $(openssl x509 -in "$CERT_DIR/_wildcard.dsas.local+4.pem" -noout -enddate 2>/dev/null | cut -d= -f2)"
echo ""
echo "Next steps:"
echo "  1. Run 'dotman template apply' to generate Caddyfile"
echo "  2. Reload Caddy: cd ~/dev/dsas-workspace && pnpm caddy:reload"
echo "  3. Test: https://hq.dsas.local (should show trusted lock icon)"
echo ""
