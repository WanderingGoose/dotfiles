# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed by Coleman (a workspace management tool) that provides automated setup and configuration for a macOS development environment. The dotfiles follow a topic-based organization pattern where each tool/technology has its own directory with relevant configuration files.

## Key Commands

### Initial Setup

```bash
# Full bootstrap (sets up git config, installs all dotfiles, runs installers)
./script/bootstrap

# Install all components (runs all install.sh scripts)
./script/install

# Update and manage dotfiles via the dot command
bin/dot        # Run updates and maintenance
bin/dot --edit # Open dotfiles directory in $EDITOR
```

### Component Installers

Each component has its own installer script that can be run independently:

- `zsh/install.sh` - Sets up oh-my-zsh with plugins (autosuggestions, syntax-highlighting)
- `homebrew/install.sh` - Installs Homebrew if not present
- `volta/install.sh` - Node.js version manager setup
- `rust/install.sh` - Rust toolchain setup
- `go/install.sh` - Go environment setup
- `starship/install.sh` - Cross-shell prompt setup
- `fonts/install.sh` - Development fonts installation

## Architecture & Structure

### Symlink System

The bootstrap process creates symlinks from `*.symlink` files to the home directory:

- `git/gitconfig.symlink` → `~/.gitconfig`
- `zsh/zshrc.symlink` → `~/.zshrc`
- `git/gitignore.symlink` → `~/.gitignore`

### Topic-Based Organization

Each directory represents a specific tool/technology with its own:

- `install.sh` - Installation script for that component
- `*.zsh` files - Shell configuration loaded by `.zshrc`:
  - `path.zsh` - PATH modifications (loaded first)
  - `aliases.zsh` - Command aliases
  - `env.zsh` - Environment variables
  - `config.zsh` - General configuration
  - `completion.zsh` - Command completions (loaded last)

### Coleman Integration

The `.coleman/` directory contains workspace configuration:

- `coleman.config.yaml` - User settings and dotfiles repository configuration
- `coleman.workspace.yaml` - Project workspace definitions with git configurations

### Shell Configuration Loading Order

1. `.zshrc` sources `~/.localrc` for private environment variables
2. Loads oh-my-zsh with configured plugins
3. Sources all `path.zsh` files first
4. Sources all other `.zsh` files except completions
5. Initializes tools (pyenv, pnpm, volta, starship)

## Important Configuration Details

### Development Tools

- **Package Manager**: PNPM preferred (configured in PATH)
- **Node.js**: Managed via Volta (`~/.volta`)
- **Python**: Managed via pyenv (conditionally loaded for 'headninja' user)
- **Java**: Microsoft OpenJDK 21 at `/Library/Java/JavaVirtualMachines/microsoft-21.jdk`
- **SSH**: Configured to use 1Password agent at `~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock`

### Git Configuration

- Local git configuration stored in `git/gitconfig.local.symlink` (not tracked)
- Generated during bootstrap from `git/gitconfig.local.symlink.example`
- Uses macOS keychain for credentials

### Environment Variables

- Private variables stored in `~/.localrc` (sourced by `.zshrc`, not tracked)
- Project directory: `~/source` (for `c [tab]` navigation)
- Dotnet telemetry disabled via `DOTNET_CLI_TELEMETRY_OPTOUT=1`

## Working with the Codebase

### Adding New Components

1. Create a new directory for the component
2. Add an `install.sh` script if installation is needed
3. Add relevant `*.zsh` files for shell configuration
4. Symlinks are created by adding `*.symlink` files

### Modifying Shell Configuration

- Edit topic-specific `.zsh` files rather than modifying `.zshrc` directly
- Use `~/.localrc` for machine-specific or private configurations
- Run `source ~/.zshrc` to reload configuration

### Testing Changes

After making changes to installers or configuration:

```bash
# Test individual installer
sh -c "./component/install.sh"

# Run full installation suite
./script/install

# Reload shell configuration
source ~/.zshrc
```
