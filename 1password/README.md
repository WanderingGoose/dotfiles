# 🔐 1Password Integration

1Password provides both SSH key management and secrets access for Captain Goose's fleet.

## SSH Agent

The 1Password SSH agent stores and manages SSH keys securely. Keys are unlocked using biometric authentication (Touch ID) instead of passphrases.

### How It Works

1. SSH keys are stored in 1Password
2. The 1Password agent socket provides access to these keys
3. `SSH_AUTH_SOCK` environment variable points to 1Password's socket
4. Git, SSH, and other tools automatically use 1Password for authentication

### Configuration

**Automatic Setup:**

- The `~/.dotfiles/zsh/1password.zsh` file sets `SSH_AUTH_SOCK` automatically
- The `~/.ssh/config` file directs SSH to use 1Password's agent
- Works identically on Big-Mac and Little-Mac

**Manual Verification:**

```bash
# Check SSH_AUTH_SOCK points to 1Password
echo $SSH_AUTH_SOCK
# Should show: /Users/headninja/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock

# List keys in 1Password agent
ssh-add -l
```

## Secrets Management with 1Password CLI

The 1Password CLI (`op`) allows accessing secrets stored in Secure Notes and Items directly from code and scripts.

### Installation

```bash
# Install via Homebrew
brew install --cask 1password-cli

# Verify installation
op --version
```

### Authentication

First-time setup requires signing in:

```bash
# Sign in to your account
op signin

# For subsequent uses, authenticate with biometrics
eval $(op signin)
```

### Secret Reference Format

Secrets are referenced using the format:

```
op://[Vault]/[Item]/[Field]
```

**Examples:**

- `op://Private/OpenAI/api_key`
- `op://Work/GitHub/personal_access_token`
- `op://Private/Vercel/blob_token`

### Using Secrets in Code

**Node.js/TypeScript:**

```typescript
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

async function getSecret(reference: string): Promise<string> {
  const { stdout } = await execAsync(`op read "${reference}"`);
  return stdout.trim();
}

// Usage
const apiKey = await getSecret('op://Private/OpenAI/api_key');
```

**Shell Scripts:**

```bash
# Read a secret
API_KEY=$(op read "op://Private/OpenAI/api_key")

# Use in .env files
echo "OPENAI_API_KEY=$(op read 'op://Private/OpenAI/api_key')" > .env
```

**Python:**

```python
import subprocess

def get_secret(reference: str) -> str:
    result = subprocess.run(
        ['op', 'read', reference],
        capture_output=True,
        text=True
    )
    return result.stdout.strip()

# Usage
api_key = get_secret('op://Private/OpenAI/api_key')
```

### Common 1Password CLI Commands

```bash
# List all vaults
op vault list

# List items in a vault
op item list --vault Private

# Get full item details
op item get "OpenAI" --vault Private

# Read specific field
op read "op://Private/OpenAI/api_key"

# Create a new item
op item create --category "API Credential" \
  --title "New Service" \
  --vault Private \
  api_key[password]="secret-key-here"
```

### Best Practices

**DO:**

- ✅ Store ALL secrets in 1Password (API keys, tokens, passwords)
- ✅ Use Secure Notes for complex configurations
- ✅ Reference secrets via `op read` instead of environment variables
- ✅ Keep 1Password vault organized (Private, Work, Shared, etc.)
- ✅ Use descriptive item names and fields

**DON'T:**

- ❌ Commit secrets to Git (even in .env files)
- ❌ Share secrets via Slack, email, or other channels
- ❌ Hardcode secrets in code
- ❌ Export secrets to plain text files

### Storing Secrets for DSAS Projects

**Recommended Structure:**

```
Vault: Private
├── DSAS - Production Site
│   ├── vercel_token
│   └── deployment_hook
├── DSAS - HQ
│   ├── neon_db_url
│   ├── stripe_secret_key
│   ├── stripe_webhook_secret
│   ├── resend_api_key
│   └── google_calendar_credentials (JSON)
├── DSAS - APIs
│   ├── openai_api_key
│   ├── anthropic_api_key
│   └── google_cloud_api_key
└── GitHub
    ├── personal_access_token
    └── ssh_key (managed by SSH agent)
```

**Access in DSAS HQ:**

```typescript
// In setup or config file
const secrets = {
  neonDbUrl: await getSecret('op://Private/DSAS - HQ/neon_db_url'),
  stripeKey: await getSecret('op://Private/DSAS - HQ/stripe_secret_key'),
  resendKey: await getSecret('op://Private/DSAS - HQ/resend_api_key')
};
```

### Troubleshooting

**SSH agent not working:**

```bash
# Restart 1Password application
# Check that SSH agent is enabled in 1Password settings:
# 1Password → Settings → Developer → SSH Agent

# Verify socket exists
ls -la ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
```

**CLI authentication errors:**

```bash
# Re-authenticate
op signin

# Check if signed in
op whoami
```

**Biometric prompt not appearing:**

- Ensure 1Password is running
- Check System Settings → Touch ID & Password
- Restart 1Password

## Cross-Machine Synchronization

**What Syncs:**

- ✅ SSH keys (stored in 1Password vault)
- ✅ Secrets and Secure Notes
- ✅ 1Password items and vaults

**What Doesn't Sync:**

- ❌ CLI authentication state (sign in on each machine)
- ❌ `SSH_AUTH_SOCK` (set by dotfiles on each machine)

**Setup on New Machine:**

1. Install 1Password app
2. Enable SSH agent in settings
3. Install 1Password CLI: `brew install --cask 1password-cli`
4. Sign in: `op signin`
5. Pull dotfiles and run setup
6. SSH agent and secrets access will work automatically

---

**Captain:** Alec W (Captain Goose)
**Ships:** Big-Mac & Little-Mac
**Security:** All secrets in 1Password, never in Git 🔐
