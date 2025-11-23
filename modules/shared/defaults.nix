{ lib, ... }:

let
  defaultsType = import ./types.nix { inherit lib; };
  userHome = "/home/pietro";
in
{
  options.myDefaults = lib.mkOption {
    type = defaultsType;
    description = "Common default applications and values used across the system";
  };

  config.myDefaults = {
    # User Identity
    user = {
      name = "pietro";
      fullName = "Pietro Bondioli";
      email = "email@pietrobondioli.com.br";
      home = userHome;
    };

    # Paths
    paths = {
      scripts = "$HOME/scripts";
      nixConfig = "$HOME/personal/nixos-config";
    };

    # Git Configuration
    git = {
      baseUrl = "https://github.com/pietrobondioli";
      userName = "Pietro Bondioli";
      userEmail = "email@pietrobondioli.com.br";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBkYROpWTR4k2G7mzsT9I3SFhlL9A3wRPKHepcHmpIU";
    };

    # Neovim Configuration
    nvim = {
      repo = "nvim-config";
      localPath = "${userHome}/personal/nvim-config";
    };

    # AI Configuration
    aiConfig = {
      repo = "ai-config";
      localPath = "${userHome}/personal/ai-config";
    };

    # System Settings
    system = {
      hostname = "host";
      timezone = "America/Sao_Paulo";
      keyboardLayout = "us";
      keyboardVariant = "altgr-intl";
    };

    # Location (for gammastep, etc.)
    location = {
      latitude = -23.5;
      longitude = -46.6;
    };

    # Display Settings
    display = {
      output = "HDMI-A-1";
      resolution = "3840x2160@60.000";
      scale = 1.60;
    };

    # Catppuccin Frappe Color Palette
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
      accent = "#8caaee";
      error = "#e78284";
      success = "#a6d189";
      warning = "#e5c890";
    };

    # Typography
    fonts = {
      primary = "JetBrainsMono Nerd Font";
      sizes = {
        small = 11;
        medium = 12;
        large = 13;
      };
    };

    # Theme Settings
    theme = {
      gtk = "Adwaita-dark";
      icons = "Adwaita";
      cursor = {
        name = "Bibata-Modern-Classic";
        size = 20;
      };
    };

    # UI Design Tokens
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

    # Default Applications
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
      imageViewer = {
        desktop = "swayimg.desktop";
        package = "swayimg";
      };
      pdfViewer = {
        desktop = "org.pwmt.zathura.desktop";
        package = "zathura";
      };
      shell = "zsh";
    };

    power = {
      battery.charge = {
        startThreshold = 75;
        stopThreshold = 80;
      };
    };
  };
}
