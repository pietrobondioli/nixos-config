{ config, lib, pkgs, ... }:
let
  defaults = config.myDefaults;
  nvimRepoUrl = "${defaults.git.baseUrl}/${defaults.nvim.repo}";
  nvimLocalPath = defaults.nvim.localPath;
in
{
  home.activation.cloneNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    NVIM_REPO="${nvimLocalPath}"

    # Set GIT_SSH to use nix store ssh
    export GIT_SSH="${pkgs.openssh}/bin/ssh"

    # Clone repository if it doesn't exist, otherwise pull latest changes
    if [ ! -d "$NVIM_REPO" ]; then
      mkdir -p "$(dirname "$NVIM_REPO")"
      ${pkgs.git}/bin/git clone ${nvimRepoUrl} "$NVIM_REPO"
    else
      echo "Updating Neovim config repository..."
      cd "$NVIM_REPO"

      # Only pull if there are no uncommitted changes
      if ${pkgs.git}/bin/git diff-index --quiet HEAD --; then
        ${pkgs.git}/bin/git pull
      else
        echo "Skipping pull: uncommitted changes detected in Neovim config repository"
      fi
    fi
  '';

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink nvimLocalPath;
  };
}
