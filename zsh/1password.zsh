# 1Password SSH Agent Configuration
# Ensures SSH_AUTH_SOCK points to 1Password's agent socket
# Works on both Big-Mac and Little-Mac

# 1Password SSH agent socket location (same on all macOS machines)
OP_SSH_AGENT_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# Only set if the socket exists (1Password is installed and running)
if [ -S "$OP_SSH_AGENT_SOCK" ]; then
  export SSH_AUTH_SOCK="$OP_SSH_AGENT_SOCK"
fi

# 1Password CLI integration for accessing secrets
# Usage in code: op read "op://Private/API Keys/openai_key"
# Requires: brew install --cask 1password-cli
