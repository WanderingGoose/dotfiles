# 🏴‍☠️ Caddy HTTPS Setup

Local HTTPS configuration for development using Caddy + mkcert.

## Quick Start

### New Machine Setup

```bash
# 1. Install shared CA certificate
~/.dotfiles/caddy/trust-ca.sh

# 2. Generate local certificates
~/.dotfiles/caddy/setup.sh

# 3. Apply Dotman templates (generates Caddyfile)
dotman template apply

# 4. Start/reload Caddy
cd ~/dev/dsas-workspace  # or ~/source/dsas-workspace on Little-Mac
pnpm caddy:reload
```

### Test HTTPS

```bash
# All three domains should work with trusted certificates:
open https://hq.dsas.local
open https://dsas.local
open https://roscoe.dsas.local
```

## Files

### Templates
- **Caddyfile.template** - Caddy configuration with Dotman variables
  - Generates machine-specific Caddyfile in workspace
  - Supports both HTTP and HTTPS
  - Uses `{{SOURCE_ROOT}}`, `{{HOME}}`, `{{HOSTNAME}}`

- **env.zsh** - Environment variables for Node.js CA trust
  - Exports `NODE_EXTRA_CA_CERTS`
  - Sourced by ZSH on startup

### Scripts
- **setup.sh** - Complete HTTPS setup
  - Installs mkcert
  - Creates CA
  - Generates wildcard certificates
  - Configures Node.js trust

- **trust-ca.sh** - Install shared CA on new machine
  - Copies `rootCA.pem` from dotfiles
  - Installs to system trust store

### Certificates
- **certs/rootCA.pem** - Public CA certificate (SAFE to commit)
- **certs/.gitignore** - Blocks private keys from being committed
- **certs/README-SECURITY.md** - Security guidelines

## How It Works

### Certificate Chain

1. **CA Certificate** (`rootCA.pem`)
   - Created once on primary machine
   - Shared across all machines via dotfiles
   - Both machines trust this CA

2. **Site Certificates** (`_wildcard.dsas.local+4.pem`)
   - Generated locally on each machine
   - Different on each machine
   - Both signed by same CA = both trusted

### File Locations

| File | Location | Committed? |
|------|----------|------------|
| Public CA Cert | `~/.dotfiles/caddy/certs/rootCA.pem` | ✅ YES |
| Private CA Key | `$(mkcert -CAROOT)/rootCA-key.pem` | ❌ NO |
| Site Certificate | `~/.caddy/certs/_wildcard.dsas.local+4.pem` | ❌ NO |
| Site Private Key | `~/.caddy/certs/_wildcard.dsas.local+4-key.pem` | ❌ NO |
| Caddyfile | `{{SOURCE_ROOT}}/dsas-workspace/Caddyfile` | ❌ NO (generated) |

## Domains

All `.local` domains support both HTTP and HTTPS:

- `http://hq.dsas.local` / `https://hq.dsas.local` → DSAS HQ (port 8001)
- `http://dsas.local` / `https://dsas.local` → Production Site (port 8000)
- `http://roscoe.dsas.local` / `https://roscoe.dsas.local` → Field Companion (port 8002)

## Troubleshooting

### Certificate Not Trusted

```bash
# Reinstall CA
mkcert -uninstall
mkcert -install

# Verify installation
security find-certificate -a -c "mkcert" | grep "mkcert"
```

### Node.js Not Trusting CA

```bash
# Check environment variable
echo $NODE_EXTRA_CA_CERTS

# Should output: /Users/headninja/Library/Application Support/mkcert/rootCA.pem

# If not set, restart terminal or run:
source ~/.zshrc
```

### Caddy Not Loading HTTPS

```bash
# Check certificate paths
ls -la ~/.caddy/certs/

# Should see:
# _wildcard.dsas.local+4.pem
# _wildcard.dsas.local+4-key.pem

# Check Caddy config
cd ~/dev/dsas-workspace
caddy validate --config Caddyfile
```

### Certificate Expired

```bash
# Regenerate certificates (valid for 2+ years)
cd ~/.caddy/certs
rm _wildcard.dsas.local+4*
mkcert "*.dsas.local" "dsas.local" "localhost" "127.0.0.1" "::1"

# Reload Caddy
cd ~/dev/dsas-workspace
pnpm caddy:reload
```

## Security Notes

See [certs/README-SECURITY.md](./certs/README-SECURITY.md) for detailed security guidelines.

**Key Points:**
- ✅ Public CA cert (`rootCA.pem`) is safe to commit
- ❌ Private keys must NEVER be committed
- ❌ Site certificates should be generated locally on each machine
- 🔐 The CA private key gives complete MITM power - keep it secure!

---

**Captain:** Alec W (Captain Goose)
**Ships:** Big-Mac & Little-Mac
**Port:** Phoenix, Arizona 🌵
