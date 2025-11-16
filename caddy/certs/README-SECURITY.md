# 🔐 Certificate Security Guidelines

## What's in This Directory

- `rootCA.pem` - **Public CA certificate** (SAFE to commit to git)
- `rootCA-key.pem` - **PRIVATE CA key** (NEVER COMMIT - stays local only!)

## Critical Security Rules

### ✅ SAFE TO COMMIT:
- `rootCA.pem` - Public CA certificate that both machines use to verify site certificates

### ❌ NEVER COMMIT:
- `rootCA-key.pem` - Private CA key (gives complete MITM power!)
- `*.pem` - Site certificates (generated locally on each machine)
- `*-key.pem` - Private keys for site certificates

## How Certificates Work

1. **Big-Mac Setup:**
   - Creates CA with `mkcert -install`
   - Copies `rootCA.pem` to this directory (public cert only)
   - Generates site certs in `~/.caddy/certs/` (stays local)

2. **Little-Mac Setup:**
   - Pulls dotfiles with `rootCA.pem`
   - Installs CA: `export CAROOT=~/.dotfiles/caddy/certs && mkcert -install`
   - Generates its OWN site certs in `~/.caddy/certs/` (different from Big-Mac)

3. **Why This Works:**
   - Both machines trust the same CA (`rootCA.pem`)
   - Both generate different site certificates
   - Both site certs are signed by the same CA
   - Browsers trust both because they trust the CA

## Security Impact

**If `rootCA-key.pem` is compromised:**
- Attacker can create fake certificates for ANY domain
- Attacker can perform man-in-the-middle attacks
- All machines trusting this CA would be vulnerable

**This is why:**
- The private key NEVER leaves the machine that created it
- Only the public certificate is shared via dotfiles
- Each machine generates its own site certificates

## Certificate Location Strategy

| File Type | Location | Committed? | Why |
|-----------|----------|------------|-----|
| CA Public Cert | `~/.dotfiles/caddy/certs/rootCA.pem` | ✅ YES | Shared across machines |
| CA Private Key | `$(mkcert -CAROOT)/rootCA-key.pem` | ❌ NO | Security risk |
| Site Certs | `~/.caddy/certs/*.pem` | ❌ NO | Machine-specific |
| Site Keys | `~/.caddy/certs/*-key.pem` | ❌ NO | Security risk |

---

**Remember:** When in doubt, DON'T commit it. Private keys are PRIVATE! 🔐
