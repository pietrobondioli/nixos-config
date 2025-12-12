{ config, pkgs, ... }:
let
  defaults = config.myDefaults;
  paths = defaults.paths;
  apps = defaults.applications;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      # Directory Navigation
      ra = "ranger";
      "cd" = "z"; # Use 'z' for autojump-like directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      zz = "zi";

      # User Aliases
      "v." = "nvim .";
      v = "nvim";
      c = "clear";

      # Enhanced ls Aliases using eza
      ls = "eza -alg --color=always --group-directories-first --git";
      l = "eza -alg --color=always --group-directories-first --git";
      ll = "eza -aliSgh --color=always --group-directories-first --icons --header --long --git";
      lt = "eza -@alT --color=always --git";
      llt = "eza --oneline --tree --icons --git-ignore";
      lr = "eza -alg --sort=modified --color=always --group-directories-first --git";

      # Clipboard Management (Wayland)
      cwd = "pwd | tr -d '\\n' | wl-copy";
      copy = "wl-copy";
      paste = "wl-paste";

      # Lazygit and Lazydocker
      lg = "lazygit";
      gg = "lazygit";
      ld = "lazydocker";

      # Docker Utilities
      docker-compose = "docker compose";

      # Network Utilities
      publicip = "dig +short myip.opendns.com @resolver1.opendns.com";

      # Miscellaneous
      rr = "rm -rf";
      md = "mkdir -p";
      path = "echo -e \${PATH//:/\\\\n}";
      map = "xargs -n1";
      reload = "exec \${SHELL} -l";

      # Dotfiles and Configuration Management
      nixrc = "cd ${paths.nixConfig} && nvim .";
      nvimrc = "cd ${defaults.nvim.localPath} && nvim .";

      # App Clean Run Utility
      clean-run = "${paths.scripts}/clean-run";
    };

    history = { size = 10000; path = "$HOME/.zsh_history"; };

    sessionVariables = {
      EDITOR = apps.editor.command;
      BROWSER = apps.browser.package;
      TERMINAL = apps.terminal.package;
      USER_LOG_DIR = "$HOME/logs";
      SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
    };

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-history-substring-search"
        "wfxr/forgit"
        "hlissner/zsh-autopair"
      ];
    };
    oh-my-zsh = { enable = true; plugins = [ "git" "fzf" ]; };
    initContent = ''
      source ${paths.scripts}/utils
      local -a SOURCE_FILES=(
        "${paths.scripts}/dev"
        "${paths.scripts}/fzf"
        "${paths.scripts}/git"
        "${paths.scripts}/history"
        "${paths.scripts}/mix"
        "${paths.scripts}/nav"
        "${paths.scripts}/zellij"
        "${paths.scripts}/zellij_autostart_config"
        "${paths.scripts}/zellij_tab_name_update"
        "${paths.scripts}/secrets"
        "${paths.scripts}/use-dotnet"
      )
      for config in $SOURCE_FILES; do
        [[ -f "$config" ]] && source "$config"
      done

      zellij_tab_name_update
      chpwd_functions+=(zellij_tab_name_update)
      zellij_autostart_config
      neofetch --ascii "$(fortune | cowsay -W 40)" | lolcat
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_status$cmd_duration$line_break$character";

      username = {
        show_always = true;
        format = "[$user]($style)@";
        style_user = "bold blue";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) in ";
        style = "bold green";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = false;
        style = "bold cyan";
      };

      git_branch = {
        format = "on [$symbol$branch]($style) ";
        symbol = " ";
        style = "bold purple";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold red";
      };

      cmd_duration = {
        min_time = 500;
        format = "took [$duration]($style) ";
        style = "bold yellow";
      };

      time = {
        disabled = false;
        format = "at [$time]($style) ";
        style = "bold white";
        time_format = "%H:%M:%S";
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
}
