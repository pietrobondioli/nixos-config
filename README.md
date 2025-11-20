# NixOS Configuration

This repository manages my personal NixOS setup using Nix Flakes and home-manager.

## Key Files & Structure

-   **`flake.nix`**: Defines the project's inputs (like `nixpkgs`, `home-manager`) and sets up the NixOS and home-manager configurations.
-   **`configuration.nix`**: Main system-wide configuration, importing modules from `modules/system/`.
-   **`home.nix`**: Main user-specific configuration (via home-manager), importing modules from `modules/home/`.
-   **`modules/system/`**: System-level settings (e.g., networking, boot, core packages).
-   **`modules/home/`**: User-level settings (e.g., shell config, user packages, theming).
-   **`modules/shared/`**: Common options and values used by both system and home modules.
-   **`dotfiles/`**: Contains configuration files (dotfiles) symlinked into the home directory.

## How to Add/Edit

-   **System-wide**: Create a `.nix` file in `modules/system/` (e.g., `modules/system/programs/my-app.nix`) and import it into `configuration.nix`.
-   **User-specific**: Create a `.nix` file in `modules/home/` (e.g., `modules/home/programs/my-tool.nix`) and import it into `home.nix`.
-   **Dotfiles**: Place the file in `dotfiles/` and add a `home.file` entry in `modules/home/config/files.nix` to symlink it.

## Applying Changes

To apply your configuration changes, run this command from the repository root:

```bash
nixos-rebuild switch --flake .#nixos
```

## Conventions

The configuration is highly modular and separated by concern, making it easy to manage and understand.