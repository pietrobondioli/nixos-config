{ config, lib, pkgs, ... }:
let
  defaults = config.myDefaults;
  aiConfigRepoUrl = "${defaults.git.baseUrl}/${defaults.aiConfig.repo}";
  aiConfigLocalPath = defaults.aiConfig.localPath;
in
{
  # Clone the ai-config repository if it doesn't exist
  home.activation.cloneAiConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    AI_CONFIG_REPO="${aiConfigLocalPath}"
    if [ ! -d "$AI_CONFIG_REPO" ]; then
      mkdir -p "$(dirname "$AI_CONFIG_REPO")"
      ${pkgs.git}/bin/git clone ${aiConfigRepoUrl} "$AI_CONFIG_REPO"
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
