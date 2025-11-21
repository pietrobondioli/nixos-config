#!/usr/bin/env bash

# Discord clean run definition

clean_run_discord() {
    # Step 1: Kill Discord process
    print_info "Killing Discord process..."
    if killall discord 2>/dev/null || killall Discord 2>/dev/null; then
        print_success "Discord process killed"
    else
        print_warning "Discord process not found (may not be running)"
    fi

    # Step 2: Remove cache
    if [ -d "$HOME/.config/discord/Cache" ]; then
        print_info "Removing Discord cache..."
        rm -rf "$HOME/.config/discord/Cache"
        rm -rf "$HOME/.config/discord/Code Cache"
        rm -rf "$HOME/.config/discord/GPUCache"
        print_success "Cache cleared"
    else
        print_warning "No cache directory found"
    fi

    # Step 3: Start Discord
    print_info "Starting Discord..."
    discord &>/dev/null &
    print_success "Discord started"
}
