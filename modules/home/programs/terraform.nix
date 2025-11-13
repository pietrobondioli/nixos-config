{ pkgs, ... }: {
  # Terraform configuration
  home.file.".terraformrc".text = ''
    plugin_cache_dir   = "$HOME/.terraform.d/plugin-cache"
    disable_checkpoint = true
  '';

  # Create plugin cache directory
  home.activation.terraformPluginCache = ''
    mkdir -p "$HOME/.terraform.d/plugin-cache"
  '';

  # Environment variables for Terraform
  home.sessionVariables = {
    TF_PLUGIN_CACHE_DIR = "$HOME/.terraform.d/plugin-cache";
    # Uncomment to disable telemetry
    # TF_CLI_ARGS = "-no-color";
  };
}
