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
    alacritty
    fuzzel
    firefox

    # Clipboard manager
    copyq
    wl-clipboard

    # Screen recording
    kooha

    _1password-cli
    _1password-gui

    # --- IDEs / Editors ---
    vscode
    neovim
    #jetbrains.rider # For .NET (use rider-fhs for better compatibility)

    # --- Common CLI Tools ---
    ripgrep  # Fast search
    fzf      # Fuzzy finder
    htop     # Process monitor

    # AI
    github-copilot-cli

    lazydocker
    lazygit

    # bin
    nodejs_24
    go
    go-tools
    rustc
    cargo
    kubectl
    helm
    minikube
    k9s
    zellij
    gcc
    dotnet-sdk_8
    dotnet-aspnetcore_8
    jdk
    python3
    lua

    awscli2
    aws-vault

    fortune
    cowsay
    lolcat
    neofetch

    discord
    teams
    spotify
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

  home.file."scripts" = {
    source = ./dotfiles/scripts;
    recursive = true;
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

  # CopyQ clipboard manager service
  systemd.user.services.copyq = {
    Unit = {
      Description = "CopyQ clipboard manager";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.copyq}/bin/copyq";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = ["graphical-session.target"];
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

  # Environment variables for dark mode
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}

