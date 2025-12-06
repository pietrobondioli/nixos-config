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
