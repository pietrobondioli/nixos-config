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
    rustc
    kubectl
    npm
    zellij
    # dotnetCorePackages.sdk_9_0_1xx-bin
    # dotnetCorePackages.aspnetcore_9_0-bin
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

  xdg.configFile."scripts" = {
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

    # histSize = 10000;
    # histFile = "$HOME/.zsh_history";
    # setOptions = [
    #   "HIST_IGNORE_ALL_DUPS"
    # ];

    # Using antidote plugin manager
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-history-substring-search"
        "MichaelAquilina/zsh-auto-notify"
        "wfxr/forgit"
        "hlissner/zsh-autopair"
      ];
    };

    # Replaces your Oh My Zsh section
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" ]; # Add your OMZ plugins
    };

    # This replaces `eval $(zoxide init zsh)`
    # initExtraBeforeCompInit = ''
    #   eval "$(zoxide init zsh)"
    # '';

    # This is for everything else
    initExtra = ''
      # Source your custom files
      source $HOME/scripts/vars
      source $HOME/scripts/utils
      source $HOME/scripts/aliases

      # Run your startup command
      neofetch --ascii "$(fortune | cowsay -W 40)" | lolcat

      # Source your p10k config
      # We will manage this file with Nix!
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
}

