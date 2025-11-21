#!/usr/bin/env bash

# Vesktop clean run definition

clean_run_vesktop() {
    # Step 1: Kill Vesktop process
    print_info "Killing Vesktop process..."
    if killall vesktop 2>/dev/null; then
        print_success "Vesktop process killed"
    else
        print_warning "Vesktop process not found (may not be running)"
    fi

    # Step 2: Remove cache
    if [ -d "$HOME/.config/vesktop/Cache" ]; then
        print_info "Removing Vesktop cache..."
        rm -rf "$HOME/.config/vesktop/Cache"
        rm -rf "$HOME/.config/vesktop/Code Cache"
        rm -rf "$HOME/.config/vesktop/GPUCache"
        print_success "Cache cleared"
    else
        print_warning "No cache directory found"
    fi

    # Step 3: Start Vesktop
    print_info "Starting Vesktop..."
    vesktop &>/dev/null &
    print_success "Vesktop started"
}
