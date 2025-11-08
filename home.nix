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
    dotnetCorePackages.sdk_9_0_1xx-bin
    dotnetCorePackages.aspnetcore_9_0-bin
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

  home.file.".zshrc" = {
    source = ./dotfiles/.zshrc;
  };

  # programs.zsh = {
  #   enable = true;
  # };

  # 3. AUTOMATIC DEV SHELLS (This is the magic!)
  # This configures direnv to automatically load the
  # dev shells defined in your project's flake.nix
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

