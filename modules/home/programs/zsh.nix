{ config, pkgs, ... }:
let
  paths = config.myDefaults.paths;
  apps = config.myDefaults.applications;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      # System aliases
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";

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
      secrets = "ripsecrets";
      path = "echo -e \${PATH//:/\\\\n}";
      map = "xargs -n1";
      reload = "exec \${SHELL} -l";

      # Dotfiles and Configuration Management
      dotfilesrc = "cd ${paths.nixConfig} && nvim .";

      makenix = "sudo nixos-rebuild switch --flake ${paths.nixConfig}#nixos --log-format internal-json -v |& nom --json";
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
        "romkatv/powerlevel10k"
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
      )
      for config in $SOURCE_FILES; do
        [[ -f "$config" ]] && source "$config"
      done

      zellij_tab_name_update
      chpwd_functions+=(zellij_tab_name_update)
      zellij_autostart_config
      neofetch --ascii "$(fortune | cowsay -W 40)" | lolcat
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
  home.file.".p10k.zsh".source = ../../../dotfiles/.p10k.zsh;
}
