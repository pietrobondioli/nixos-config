# Problems During NixOS Setup Journey

I'm going to use this file to document problems I encounter while setting up NixOS, along with their solutions.

## Fixing nvim-treesitter Errors on NixOS

### The Problem

When starting Neovim (especially with LazyVim) on NixOS, you see errors like:

```
[nvim-treesitter/install/bash] error: Error during "tree-sitter build": 
Could not start dynamically linked executable: tree-sitter
NixOS cannot run dynamically linked executables intended for generic
linux environments out of the box.
```

### Why This Happens

NixOS is different from normal Linux distributions. It doesn't have a standard `/lib64/ld-linux-x86-64.so.2` dynamic linker that most Linux programs expect. This means:

- nvim-treesitter can't compile parsers using the `tree-sitter` CLI
- Mason can't run downloaded LSP servers
- Many downloaded binaries won't work

These tools expect to download and run pre-built binaries that work on "normal" Linux, but NixOS isolates everything in the Nix store.

### The Solution

Enable `nix-ld` in your NixOS configuration:

```nix
# In your configuration.nix (or in your flake's NixOS configuration)
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];
}
```

Then rebuild:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### What nix-ld Does

`nix-ld` provides a compatibility layer that allows NixOS to run dynamically linked executables that weren't built specifically for NixOS. It creates the standard dynamic linker path that normal Linux programs expect.

### Result

After enabling nix-ld:

- ✅ nvim-treesitter can compile parsers
- ✅ Mason-installed LSP servers work
- ✅ No more startup errors
- ✅ Downloaded binaries in Neovim work normally

---

**TL;DR:** NixOS can't run normal Linux binaries by default. Enable `nix-ld` to fix it.
