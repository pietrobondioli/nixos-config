{ config, pkgs, lib, inputs, ... }:

let
  # Define the onePassPath outside the main attribute set if you want to reuse it elsewhere
  onePassPath = "~/.1password/agent.sock";
in {
  home.username = "pietro";
  home.homeDirectory = "/home/pietro";
  home.stateVersion = "25.05";
  programs.bash = {
      enable = true;
      shellAliases = {
          hi = "echo hello";
      };
  };

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser.enable = true;

  home.packages = with pkgs; [
    # Terminal emulators
    alacritty
    foot

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
    claude-code

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
    chromium

    wlr-randr

    # Notifications
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

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font 12";
      anchor = "top-right";
      background-color = "#1e1e2eFF";
      border-color = "#89b4faFF";
      border-size = 2;
      border-radius = 8;
      default-timeout = 8000;
      height = 120;
      width = 400;
      padding = "12";
      margin = "8";
      text-color = "#cdd6f4FF";
      progress-color = "#89b4faFF";
      icons = true;
    };
    extraConfig = ''
      [urgency=low]
      border-color=#45475a
      [urgency=high]
      border-color=#f38ba8
    '';
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      extraOptions = {
        IdentityAgent = onePassPath;
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Pietro Bondioli";
        email = "email@pietrobondioli.com.br";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBkYROpWTR4k2G7mzsT9I3SFhlL9A3wRPKHepcHmpIU";
        enableSigning = true;
      };

      url."git@github.com:" = {
        insteadOf = "https://github.com/";
      };

      gpg = {
        format = "ssh";
        ssh = {
          program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
          allowedSignersFile = "~/.ssh/allowed_signers";
        };
      };

      push = {
        autoSetupRemote = true;
      };

      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };

      apply.whitespace = "fix";
      grep.lineNumber = true;
      branch.sort = "-committerdate";
      color.ui = true;
      rebase.autoStash = true;
      gist.private = "yes";
      log.decorate = "short";
      fetch = {
        prune = true;
        output = "compact";
      };
      help.autocorrect = "prompt";
      merge = {
        log = true;
        conflictstyle = "diff3";
      };
    };
  };

  xdg.configFile."niri" = {
    source = ./dotfiles/niri;
    recursive = true;
  };

  xdg.configFile."zellij" = {
    source = ./dotfiles/zellij;
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
  };

  # Beautiful Rofi configuration with Catppuccin Mocha theme
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-emoji ];
    package = pkgs.rofi;
    font = "JetBrainsMono Nerd Font 12";
    terminal = "kitty";

    extraConfig = {
      modi = "drun,run,window,ssh";
      show-icons = true;
      icon-theme = "Adwaita";
      display-drun = " Apps";
      display-run = " Run";
      display-window = "󰖯 Windows";
      display-ssh = " SSH";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";

      # Layout
      width = 35;
      lines = 10;
      columns = 1;

      # Behavior
      sort = true;
      sorting-method = "fzf";
      matching = "fuzzy";
      scroll-method = 0;
      disable-history = false;
      cycle = true;

      # Appearance
      hide-scrollbar = true;
      fixed-num-lines = true;
      sidebar-mode = false;
      hover-select = true;
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg = mkLiteral "#1e1e2eff";
        bg-alt = mkLiteral "#313244ff";
        bg-selected = mkLiteral "#45475aff";

        fg = mkLiteral "#cdd6f4ff";
        fg-alt = mkLiteral "#7f849cff";

        border = mkLiteral "#89b4faff";
        border-alt = mkLiteral "#b4befeff";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";

        font = "JetBrainsMono Nerd Font 12";

        margin = 0;
        padding = 0;
        spacing = 0;
      };

      window = {
        location = mkLiteral "center";
        width = 640;
        border-radius = 12;

        background-color = mkLiteral "@bg";
        border = 2;
        border-color = mkLiteral "@border";
      };

      mainbox = {
        padding = 12;
        background-color = mkLiteral "inherit";
      };

      inputbar = {
        padding = mkLiteral "12px 16px";
        spacing = 12;

        background-color = mkLiteral "@bg-alt";
        border-radius = 8;
        border = 0;

        children = map mkLiteral [ "prompt" "entry" ];
      };

      prompt = {
        text-color = mkLiteral "@border";
        font = "JetBrainsMono Nerd Font Bold 13";
      };

      entry = {
        placeholder = "Search...";
        placeholder-color = mkLiteral "@fg-alt";
        text-color = mkLiteral "@fg";
        cursor = mkLiteral "text";
      };

      message = {
        margin = mkLiteral "12px 0 0";
        border-radius = 8;
        border-color = mkLiteral "@border";
        background-color = mkLiteral "@bg-alt";
      };

      textbox = {
        padding = 12;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "@fg";
      };

      listview = {
        margin = mkLiteral "12px 0 0";
        columns = 1;
        lines = 8;
        fixed-height = false;

        background-color = mkLiteral "transparent";

        scrollbar = false;
        spacing = 4;
        cycle = true;
        dynamic = true;
      };

      element = {
        padding = mkLiteral "10px 14px";
        spacing = 12;
        border-radius = 6;

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";

        cursor = mkLiteral "pointer";
      };

      "element normal.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "element normal.urgent" = {
        background-color = mkLiteral "#f38ba8ff";
        text-color = mkLiteral "@bg";
      };

      "element normal.active" = {
        background-color = mkLiteral "#a6e3a1ff";
        text-color = mkLiteral "@bg";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@bg-selected";
        text-color = mkLiteral "@border";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "#f38ba8ff";
        text-color = mkLiteral "@bg";
      };

      "element selected.active" = {
        background-color = mkLiteral "#a6e3a1ff";
        text-color = mkLiteral "@bg";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "element-icon" = {
        size = 28;
        cursor = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };

      "element-text" = {
        vertical-align = mkLiteral "0.5";
        cursor = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
    extraConfig = ''
      background #1e1e2e
      foreground #cdd6f4
      selection_background #45475a
      selection_foreground #cdd6f4
      cursor #89b4fa
      cursor_text_color #1e1e2e
      url_color #89b4fa
      active_tab_background #313244
      active_tab_foreground #cdd6f4
      inactive_tab_background #1e1e2e
      inactive_tab_foreground #585b70
      color0 #45475a
      color1 #f38ba8
      color2 #a6e3a1
      color3 #f9e2af
      color4 #89b4fa
      color5 #f5c2e7
      color6 #94e2d5
      color7 #bac2de
      color8 #585b70
      color9 #f38ba8
      color10 #a6e3a1
      color11 #f9e2af
      color12 #89b4fa
      color13 #f5c2e7
      color14 #94e2d5
      color15 #a6adc8
      enable_audio_bell no
      background_opacity 0.95
    '';
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
      TERMINAL = "kitty";
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

    initContent = ''
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
    enableZshIntegration = true;
  };

  home.file.".p10k.zsh" = {
    source = ./dotfiles/.p10k.zsh;
  };

  # AUTOMATIC DEV SHELLS
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
    NIXOS_OZONE_WL = "1";
    BROWSER = "zen";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Default applications for file types
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Web browser - all browser-related MIME types
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";

      # PDF files
      "application/pdf" = "org.pwmt.zathura.desktop";

      # Text files
      "text/plain" = "nvim.desktop";

      # Images
      "image/png" = "mpv.desktop";
      "image/jpeg" = "mpv.desktop";
      "image/jpg" = "mpv.desktop";
      "image/gif" = "mpv.desktop";
      "image/webp" = "mpv.desktop";

      # Videos
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";

      # Audio
      "audio/mpeg" = "mpv.desktop";
      "audio/mp3" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";

      # File manager
      "inode/directory" = "thunar.desktop";
    };
  };

  # Gammastep (redshift for Wayland)
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = -23.5;
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
