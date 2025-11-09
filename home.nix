{ config, pkgs, ... }:

{
  home.username = "pietro";
  home.homeDirectory = "/home/pietro";
  home.stateVersion = "25.05";
  programs.bash = {
      enable = true;
      shellAliases = {
          hi = "echo hello";
      };
  };

  home.packages = with pkgs; [
    # Terminal emulators
    alacritty
    foot
    kitty

    # Wayland utilities
    waybar
    slurp
    grim
    wtype
    swaybg
    swaylock
    swayidle

    # Browsers
    firefox

    # File manager
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin

    # Media
    mpv
    pwvucontrol

    # Clipboard manager
    copyq
    cliphist
    wl-clipboard

    # Screenshot and screen recording
    satty
    gpu-screen-recorder
    wf-recorder

    # Security
    _1password-cli
    _1password-gui

    # IDEs / Editors
    vscode
    neovim
    tree-sitter
    #jetbrains.rider

    # CLI Tools
    ripgrep
    fzf
    htop
    direnv
    nixpkgs-fmt

    # AI
    github-copilot-cli

    # Container/K8s tools
    lazydocker
    lazygit
    kubectl
    helm
    minikube
    k9s

    # Development languages & tools
    nodejs_24
    go
    go-tools
    rustc
    cargo
    zellij
    dotnet-sdk_8
    dotnet-aspnetcore_8
    jdk
    python3
    lua
    gcc
    gnumake

    # Cloud tools
    awscli2
    aws-vault

    # Fun stuff
    fortune
    cowsay
    lolcat
    neofetch

    # Communication
    vesktop
    teams-for-linux
    spotify

    wlr-randr

    # Notifications
    mako
    libnotify

    # System monitor
    btop

    # Brightness
    brightnessctl

    # Portal for screen sharing
    xdg-desktop-portal-wlr

    # PDF reader
    zathura

    # Fonts
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.meslo-lg
    nerd-fonts.symbols-only
  ];

  programs.git = {
    enable = true;
    userName = "Pietro Bondioli";
    userEmail = "email@pietrobondioli.com.br";
  };

  xdg.configFile."niri" = {
    source = ./dotfiles/niri;
    recursive = true;
  };

  xdg.configFile."zellij" = {
    source = ./dotfiles/zellij;
    recursive = true;
  };

  xdg.configFile."kitty" = {
    source = ./dotfiles/kitty;
    recursive = true;
  };

  # Wallpapers
  xdg.configFile."wallpapers" = {
    source = ./dotfiles/wallpapers;
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = ./dotfiles/waybar;
    recursive = true;
  };

  xdg.configFile."rofi" = {
    source = ./dotfiles/rofi;
    recursive = true;
  };

  xdg.configFile."satty" = {
    source = ./dotfiles/satty;
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = ./dotfiles/nvim;
    recursive = true;
  };

  home.file."scripts" = {
    source = ./dotfiles/scripts;
    recursive = true;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override {
      niriSupport = true;
    };
    systemd.enable = true;
  };

  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-emoji ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
    };

    sessionVariables = {
      EDITOR = "vim";
      TERMINAL = "/usr/bin/kitty";
      USER_LOG_DIR = "$HOME/logs";
      SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/gcr/ssh";
    };

    # Using antidote plugin manager
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-history-substring-search"
        "wfxr/forgit"
        "hlissner/zsh-autopair"
        "romkatv/powerlevel10k"
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" ];
    };

    initExtra = ''
      # Disable corrections
      # unsetopt correct_all

      # Source custom configuration files
      source $HOME/scripts/vars
      source $HOME/scripts/utils
      source $HOME/scripts/aliases

      # Additional scripts
      local -a SOURCE_FILES=(
        "$HOME/scripts/dev"
        "$HOME/scripts/fzf"
        "$HOME/scripts/git"
        "$HOME/scripts/history"
        "$HOME/scripts/mix"
        "$HOME/scripts/nav"
        "$HOME/scripts/tmux"
        "$HOME/scripts/zellij"
        "$HOME/scripts/zellij_autostart_config"
        "$HOME/scripts/zellij_tab_name_update"
        "$HOME/scripts/secrets"
      )

      for config in $SOURCE_FILES; do
        if [[ -f "$config" ]]; then 
          source "$config"
        fi
      done

      # Zellij configuration
      zellij_tab_name_update
      chpwd_functions+=(zellij_tab_name_update)
      zellij_autostart_config

      # Display system info at startup
      neofetch --ascii "$(fortune | cowsay -W 40)" | lolcat

      # Source Powerlevel10k config
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true; # This might even replace the initExtra line
  };

  home.file.".p10k.zsh" = {
    source = ./dotfiles/.p10k.zsh; # <-- Copy your p10k file into your repo
  };

  # 3. AUTOMATIC DEV SHELLS (This is the magic!)
  # This configures direnv to automatically load the
  # dev shells defined in your project's flake.nix
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  systemd.user.services.cliphist = {
    Unit = {
      Description = "Clipboard history daemon";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
    };
  };

  # Dark mode for all apps
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  # Environment variables for dark mode and Wayland apps
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    NIXOS_OZONE_WL = "1";  # Enable Wayland for Electron apps
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Gammastep (redshift for Wayland)
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = -23.5;  # São Paulo coordinates
    longitude = -46.6;
    temperature = {
      day = 4500;
      night = 4500;
    };
    settings = {
      general = {
        adjustment-method = "wayland";
      };
    };
  };

  services.swayidle = {
    enable = true;
    extraArgs = [ "-w" ];
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { timeout = 600; command = "systemctl suspend"; resumeCommand = "${pkgs.swaylock}/bin/swaylock -f"; }
    ];
  };
}

