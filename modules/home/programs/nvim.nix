{ config, lib, pkgs, ... }:
let
  defaults = config.myDefaults;
  nvimRepoUrl = "${defaults.git.baseUrl}/${defaults.nvim.repo}";
  nvimLocalPath = defaults.nvim.localPath;
in
{
  home.activation.cloneNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    NVIM_REPO="${nvimLocalPath}"
    if [ ! -d "$NVIM_REPO" ]; then
      mkdir -p "$(dirname "$NVIM_REPO")"
      ${pkgs.git}/bin/git clone ${nvimRepoUrl} "$NVIM_REPO"
    fi
  '';

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink nvimLocalPath;
  };
}
