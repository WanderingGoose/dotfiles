# Caddy HTTPS Configuration
# Trust mkcert CA for Node.js applications

# Export NODE_EXTRA_CA_CERTS so Node.js apps trust our local CA
if command -v mkcert &>/dev/null; then
  export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
fi
