{ lib, ... }:

{
  # Desktop-specific overrides
  config.myDefaults = lib.mkForce {
    # User Identity (shared)
    user = {
      name = "pietro";
      fullName = "Pietro Bondioli";
      email = "email@pietrobondioli.com.br";
      home = "/home/pietro";
    };

    # Paths (shared)
    paths = {
      scripts = "$HOME/scripts";
      nixConfig = "$HOME/personal/nixos-config";
    };

    # Git Configuration (shared)
    git = {
      userName = "Pietro Bondioli";
      userEmail = "email@pietrobondioli.com.br";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBkYROpWTR4k2G7mzsT9I3SFhlL9A3wRPKHepcHmpIU";
    };

    # System Settings - DESKTOP SPECIFIC
    system = {
      hostname = "desktop";
      timezone = "America/Sao_Paulo";
      keyboardLayout = "us";
      keyboardVariant = "altgr-intl";
    };

    # Location (shared)
    location = {
      latitude = -23.5;
      longitude = -46.6;
    };

    # Display Settings - DESKTOP SPECIFIC (AMD + NVIDIA, 4K monitor)
    display = {
      output = "HDMI-A-1";
      resolution = "3840x2160@60.000";
      scale = 1.60;
    };

    # Catppuccin Frappe Color Palette (shared)
    colors = {
      # Base colors
      background = "#303446";
      foreground = "#c6d0f5";

      # Selection/highlights
      selection = "#414559";
      altBackground = "#292c3c";

      # Accent colors
      blue = "#8caaee";
      red = "#e78284";
      green = "#a6d189";
      yellow = "#e5c890";
      pink = "#f4b8e4";
      teal = "#99d1db";

      # Grays
      darkGray = "#51576d";

      # Semantic aliases
      accent = "#8caaee"; # blue
      error = "#e78284"; # red
      success = "#a6d189"; # green
      warning = "#e5c890"; # yellow
    };

    # Typography (shared)
    fonts = {
      primary = "JetBrainsMono Nerd Font";
      sizes = {
        small = 12;
        medium = 13;
        large = 14;
      };
    };

    # Theme Settings (shared)
    theme = {
      gtk = "Adwaita-dark";
      icons = "Adwaita";
      cursor = {
        name = "Bibata-Modern-Classic";
        size = 20;
      };
    };

    # UI Design Tokens (shared)
    ui = {
      borderRadius = {
        large = 12;
        medium = 8;
        small = 6;
      };
      opacity = {
        terminal = 0.98;
      };
    };

    # Default Applications (shared)
    applications = {
      browser = {
        desktop = "firefox-nightly.desktop";
        package = "firefox-nightly";
      };
      terminal = {
        desktop = "kitty.desktop";
        package = "kitty";
      };
      fileManager = {
        desktop = "thunar.desktop";
        package = "thunar";
      };
      editor = {
        desktop = "nvim-kitty.desktop";
        command = "nvim";
      };
      mediaPlayer = {
        desktop = "mpv.desktop";
        package = "mpv";
      };
      pdfViewer = {
        desktop = "org.pwmt.zathura.desktop";
        package = "zathura";
      };
      shell = "zsh";
    };
  };
}
