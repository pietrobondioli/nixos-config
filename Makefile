.PHONY: fmt lint check clean install-hooks build-desktop build-laptop test-desktop test-laptop update help

# Default target
help:
	@echo "NixOS Configuration Management"
	@echo ""
	@echo "Build commands:"
	@echo "  make build-desktop    - Build and switch to desktop configuration"
	@echo "  make build-laptop     - Build and switch to laptop configuration"
	@echo "  make test-desktop     - Test desktop configuration (no activation)"
	@echo "  make test-laptop      - Test laptop configuration (no activation)"
	@echo ""
	@echo "Maintenance:"
	@echo "  make update          - Update flake inputs"
	@echo "  make fmt             - Format all Nix files"
	@echo "  make lint            - Lint all Nix files"
	@echo "  make check           - Format and lint"
	@echo "  make clean           - Clean backup files"
	@echo "  make install-hooks   - Install git pre-commit hooks"

# Build commands
build-desktop:
	@echo "Building desktop configuration..."
	sudo nixos-rebuild switch --flake .#desktop

build-laptop:
	@echo "Building laptop configuration..."
	sudo nixos-rebuild switch --flake .#laptop

# Test commands (no activation)
test-desktop:
	@echo "Testing desktop configuration..."
	sudo nixos-rebuild test --flake .#desktop

test-laptop:
	@echo "Testing laptop configuration..."
	sudo nixos-rebuild test --flake .#laptop

# Update flake
update:
	@echo "Updating flake inputs..."
	nix flake update
	@echo "Done! Run 'make build-desktop' or 'make build-laptop' to apply updates."

# Format all Nix files
fmt:
	@echo "Formatting Nix files..."
	@find . -name '*.nix' -not -path '*/.*' -exec nixpkgs-fmt {} +
	@echo "Done!"

# Lint all Nix files
lint:
	@echo "Linting Nix files..."
	@statix check .
	@echo "Checking for dead code..."
	@deadnix -f .
	@echo "Done!"

# Format and lint
check: fmt lint

# Clean up any backup files
clean:
	@find . -name '*.nix.backup' -delete
	@echo "Cleaned backup files"

# Install git pre-commit hook
install-hooks:
	@echo "Installing git pre-commit hook..."
	@mkdir -p .git/hooks
	@echo '#!/bin/sh' > .git/hooks/pre-commit
	@echo 'make fmt' >> .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Git hook installed! Run 'make check' will run before each commit."
