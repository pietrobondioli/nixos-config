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

    if ! ${pkgs.iputils}/bin/ping -c 1 -W 2 github.com >/dev/null 2>&1; then
      echo "Network unavailable, skipping Neovim config repository update"
    elif ! ${pkgs.openssh}/bin/ssh -T -o BatchMode=yes -o ConnectTimeout=5 git@github.com 2>&1 | grep -q "successfully authenticated"; then
      echo "SSH authentication unavailable, skipping Neovim config repository update"
    elif [ ! -d "$NVIM_REPO/.git" ]; then
      mkdir -p "$(dirname "$NVIM_REPO")"
      ${pkgs.git}/bin/git clone ${nvimRepoUrl} "$NVIM_REPO"
    else
      echo "Updating Neovim config repository..."
      cd "$NVIM_REPO"
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
