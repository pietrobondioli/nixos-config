{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = { ll = "ls -l"; edit = "sudo -e"; update = "sudo nixos-rebuild switch"; };
    history = { size = 10000; path = "$HOME/.zsh_history"; };
    sessionVariables = { EDITOR = "vim"; TERMINAL = "kitty"; USER_LOG_DIR = "$HOME/logs"; SSH_AUTH_SOCK = "$HOME/.1password/agent.sock"; };
    antidote = { enable = true; plugins = [
      "zsh-users/zsh-autosuggestions"
      "zsh-users/zsh-syntax-highlighting"
      "zsh-users/zsh-completions"
      "zsh-users/zsh-history-substring-search"
      "wfxr/forgit"
      "hlissner/zsh-autopair"
      "romkatv/powerlevel10k"
    ]; };
    oh-my-zsh = { enable = true; plugins = [ "git" "fzf" ]; };
    initContent = ''
      source $HOME/scripts/vars
      source $HOME/scripts/utils
      source $HOME/scripts/aliases
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
