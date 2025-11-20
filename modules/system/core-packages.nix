{ config, pkgs, lib, inputs, ... }:

{
  # Core system packages that don't belong to any specific module
  environment.systemPackages = with pkgs; [
    ## Version Control & Network Tools
    git # Distributed version control system
    wget # Non-interactive network downloader (supports HTTP, HTTPS, FTP)
    curl # Command-line tool for transferring data with URL syntax

    ## Text Editors
    vim # Highly configurable terminal text editor

    ## File Management & Navigation
    unzip # Extract compressed files in ZIP format
    eza # Modern replacement for ls with color and git integration
    fd # Fast and user-friendly alternative to find

    ## Build Tools & System Libraries
    gcc # GNU Compiler Collection (C/C++ compiler)
    libinput # Library for handling input devices (touchpads, mice, keyboards)

    ## Hardware Information & Management
    usbutils # USB device utilities (lsusb, usb-devices)
    pciutils # PCI utilities (lspci, setpci)

    ## Process & System Monitoring
    pstree # Display process tree hierarchy
    psmisc # Process utilities (killall, fuser, pstree, etc.)

    ## Data Processing & Manipulation
    jq # Lightweight and flexible command-line JSON processor

    ## Graphics & GPU Debugging
    vulkan-tools # Vulkan utilities and debug tools (vulkaninfo, vkcube)

    ffmpeg # Multimedia framework for handling video, audio, and other multimedia files

    (pkgs.callPackage ../../packages/gemini-cli-nightly.nix { })
  ];
}
