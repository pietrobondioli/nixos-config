#!/usr/bin/env bash

# Spotify clean run definition

clean_run_spotify() {
    # Step 1: Kill Spotify process
    print_info "Killing Spotify process..."
    if killall spotify 2>/dev/null; then
        print_success "Spotify process killed"
    else
        print_warning "Spotify process not found (may not be running)"
    fi

    # Step 2: Remove cache
    if [ -d "$HOME/.cache/spotify" ]; then
        print_info "Removing Spotify cache..."
        rm -rf "$HOME/.cache/spotify"
        print_success "Cache cleared"
    else
        print_warning "No cache directory found"
    fi

    # Step 3: Remove config
    if [ -d "$HOME/.config/spotify" ]; then
        print_info "Removing Spotify config..."
        rm -rf "$HOME/.config/spotify"
        print_success "Config cleared"
    else
        print_warning "No config directory found"
    fi

    # Step 4: Start Spotify with --no-zygote flag
    print_info "Starting Spotify with --no-zygote flag..."
    spotify --no-zygote &>/dev/null &
    print_success "Spotify started"
}
