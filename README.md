# My NixOS Configuration

This repository manages my personal NixOS setup using Nix Flakes and home-manager.

## 🖥️ Multi-Host Support

This configuration supports multiple machines with shared modules:

## Key Files & Structure

- **`flake.nix`**: Defines the project's inputs and multi-host configurations.
- **`hosts/[hostname]/`**: Host-specific configurations (hardware, defaults, module imports).
- **`home.nix`**: User configuration shared across all hosts (via home-manager).
- **`modules/system/`**: System-level modules (networking, boot, programs, services).
- **`modules/home/`**: User-level modules (shell config, packages, theming).
- **`modules/shared/`**: Common options and values used by both system and home modules.
- **`dotfiles/`**: Configuration files symlinked into the home directory.

## Quick Start

### Current Desktop

```bash
nixos-rebuild switch --flake .#desktop
```

## How to Add/Edit

- **System-wide**: Create a `.nix` file in `modules/system/` and import it in `hosts/[hostname]/configuration.nix`.
- **User-specific**: Create a `.nix` file in `modules/home/` and import it in `home.nix`.
- **Host-specific**: Edit values in `hosts/[hostname]/defaults.nix` (hostname, display settings, etc.).
- **Dotfiles**: Place the file in `dotfiles/` and add a `home.file` entry in `modules/home/config/files.nix`.

## Conventions

The configuration is highly modular and separated by concern, making it easy to manage and understand.

