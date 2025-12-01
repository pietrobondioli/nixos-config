#!/usr/bin/env bash
# YubiKey Enrollment Script for U2F/FIDO2

set -e

echo "=========================================="
echo "YubiKey U2F Enrollment Script"
echo "=========================================="
echo ""

# Check if pamu2fcfg is available
if ! command -v pamu2fcfg &> /dev/null; then
    echo "❌ pamu2fcfg not found!"
    echo "Run: nix-shell -p pam_u2f"
    exit 1
fi

# Check if YubiKey is plugged in
if ! lsusb | grep -i yubico &>/dev/null; then
    echo "❌ YubiKey not detected. Please plug it in and try again."
    exit 1
fi

echo "✅ YubiKey detected"
echo ""

# Create directory if it doesn't exist
mkdir -p ~/.config/Yubico

# Check if already enrolled
if [ -f ~/.config/Yubico/u2f_keys ] && [ -s ~/.config/Yubico/u2f_keys ]; then
    echo "⚠️  Enrollment file already exists at ~/.config/Yubico/u2f_keys"
    echo ""
    echo "Current keys enrolled:"
    cat ~/.config/Yubico/u2f_keys
    echo ""
    read -p "Do you want to add another key? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo ""
        echo "Please touch your YubiKey when it blinks..."
        pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
        echo ""
        echo "✅ Additional YubiKey enrolled successfully!"
    else
        echo "Keeping existing enrollment."
        exit 0
    fi
else
    echo "Enrolling your first YubiKey..."
    echo "Please touch your YubiKey when it blinks..."
    echo ""
    pamu2fcfg > ~/.config/Yubico/u2f_keys
    echo ""
    echo "✅ YubiKey enrolled successfully!"
fi

echo ""
echo "Enrollment file location: ~/.config/Yubico/u2f_keys"
echo "Number of keys enrolled: $(wc -l < ~/.config/Yubico/u2f_keys)"
echo ""
echo "=========================================="
echo "Next Steps:"
echo "=========================================="
echo "1. Make sure your NixOS config has been rebuilt with the fixes"
echo "2. Test with: sudo -k && sudo echo test"
echo "3. You should see a prompt and need to touch your YubiKey"
echo ""
