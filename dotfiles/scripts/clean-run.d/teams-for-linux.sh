#!/usr/bin/env bash

# Teams for Linux clean run definition

clean_run_teams-for-linux() {
    # Step 1: Kill Teams process
    print_info "Killing Teams for Linux process..."
    if killall teams-for-linux 2>/dev/null || killall teams 2>/dev/null; then
        print_success "Teams for Linux process killed"
    else
        print_warning "Teams for Linux process not found (may not be running)"
    fi

    # Step 2: Remove cache
    if [ -d "$HOME/.config/teams-for-linux/Cache" ]; then
        print_info "Removing Teams for Linux cache..."
        rm -rf "$HOME/.config/teams-for-linux/Cache"
        rm -rf "$HOME/.config/teams-for-linux/Code Cache"
        rm -rf "$HOME/.config/teams-for-linux/GPUCache"
        print_success "Cache cleared"
    else
        print_warning "No cache directory found"
    fi

    # Step 3: Start Teams for Linux
    print_info "Starting Teams for Linux..."
    teams-for-linux &>/dev/null &
    print_success "Teams for Linux started"
}
