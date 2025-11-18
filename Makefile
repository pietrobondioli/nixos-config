.PHONY: fmt lint check clean

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
