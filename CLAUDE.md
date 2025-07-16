# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **GNU Guix configuration repository** that uses a modular approach for system and home environment management. The configuration is split between system-level configuration (`system.scm`) and user-level home configuration (`home.scm`).

### Key Files
- `system.scm` - Main operating system configuration
- `home.scm` - User home environment configuration (currently empty)
- `Justfile` - Build automation with common commands
- `modules/` - Modular configuration components
  - `hosts/` - Hardware-specific configurations
  - `system/` - System-level modules
  - `home/` - Home environment modules

### Module Structure
- **Hardware modules** (`modules/hosts/test/hardware.scm`): Defines filesystems, bootloader, and swap devices
- **System modules** (`modules/system/`): User groups, networking, i18n, etc.
- **Home modules** (`modules/home/`): Development tools, editors, terminals, services

## Development Commands

### System Management
```bash
# Reconfigure the entire system (requires sudo)
just sys

# Reconfigure user home environment
just home

# Update all Guix channels
just pull
```

### Manual Commands
```bash
# System reconfiguration
sudo guix system reconfigure ./system.scm --load-path=./modules

# Home reconfiguration
guix home reconfigure ./home.scm --load-path=./modules

# Update channels
guix pull --channels=.guix-channels
guix describe --format=channels > .guix-channels.lock
```

### Package Management
```bash
# Search for packages
guix search <package-name>

# Install packages to user profile
guix install <package-name>

# Update packages
guix package -u
```

## Configuration Patterns

### Using Modules
- Use `use-modules` for Guix/Guile modules
- Use `use-service-modules` for service definitions
- Use `use-package-modules` for package definitions
- Custom modules are loaded via `--load-path=./modules`

### Common Data Structures
- **Lists**: Use `cons*` for prepending elements (avoids extra null)
- **Package lists**: Use `(map specification->package '("pkg1" "pkg2"))`
- **Services**: Use `modify-services` to extend base services

### Hardware Configuration
- Filesystems: UUID-based mounting in `modules/hosts/test/hardware.scm`
- Bootloader: GRUB configuration with target device specification
- Swap: UUID-based swap space configuration

## Key Guix Concepts

### Substitutes
- Uses Chinese mirror: `https://mirror.sjtu.edu.cn/guix/`
- Includes nonguix substitutes: `https://substitutes.nonguix.org`
- Authorized keys managed via `signing-key.pub`

### Profiles
- System profile: Managed by `guix system reconfigure`
- Home profile: Managed by `guix home reconfigure`
- User profile: Managed by `guix package` commands

### Modular Design
- Split configuration into reusable modules
- Hardware-specific settings isolated in host modules
- Home and system configurations separated for flexibility