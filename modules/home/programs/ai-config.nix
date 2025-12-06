{ config, lib, pkgs, ... }:
let
  defaults = config.myDefaults;
  aiConfigRepoUrl = "${defaults.git.baseUrl}/${defaults.aiConfig.repo}";
  aiConfigLocalPath = defaults.aiConfig.localPath;
in
{
  # Clone/update the ai-config repository
  home.activation.cloneAiConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    AI_CONFIG_REPO="${aiConfigLocalPath}"

    # Set GIT_SSH to use nix store ssh
    export GIT_SSH="${pkgs.openssh}/bin/ssh"

    # Check if network is available before attempting git operations
    if ! ${pkgs.iputils}/bin/ping -c 1 -W 2 github.com >/dev/null 2>&1; then
      echo "Network unavailable, skipping AI config repository update"
      # If repo doesn't exist yet, create empty directory structure to allow symlinks
      if [ ! -d "$AI_CONFIG_REPO" ]; then
        mkdir -p "$AI_CONFIG_REPO/localcfg/.claude"
        mkdir -p "$AI_CONFIG_REPO/localcfg/.copilot"
        mkdir -p "$AI_CONFIG_REPO/localcfg/.gemini"
        echo "Created placeholder directories. Run 'home-manager switch' when network is available."
      fi
      exit 0
    fi

    # Clone repository if it doesn't exist, otherwise pull latest changes
    if [ ! -d "$AI_CONFIG_REPO" ]; then
      mkdir -p "$(dirname "$AI_CONFIG_REPO")"
      ${pkgs.git}/bin/git clone ${aiConfigRepoUrl} "$AI_CONFIG_REPO"
    else
      echo "Updating AI config repository..."
      cd "$AI_CONFIG_REPO"
      ${pkgs.git}/bin/git remote set-url origin "${aiConfigRepoUrl}"

      # Only pull if there are no uncommitted changes
      if ${pkgs.git}/bin/git diff-index --quiet HEAD --; then
        ${pkgs.git}/bin/git pull
      else
        echo "Skipping pull: uncommitted changes detected in AI config repository"
      fi
    fi
  '';

  # Symlink AI tool configuration folders
  home.file.".claude" = {
    source = config.lib.file.mkOutOfStoreSymlink "${aiConfigLocalPath}/localcfg/.claude";
  };

  home.file.".copilot" = {
    source = config.lib.file.mkOutOfStoreSymlink "${aiConfigLocalPath}/localcfg/.copilot";
  };

  home.file.".gemini" = {
    source = config.lib.file.mkOutOfStoreSymlink "${aiConfigLocalPath}/localcfg/.gemini";
  };
}
