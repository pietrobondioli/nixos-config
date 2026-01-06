{ pkgs, ... }:
let
  dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [
    sdk_8_0
    sdk_9_0
    sdk_10_0
  ];
in
{
  home.sessionVariables = {
    DOTNET_ROOT = "${dotnetCombined}/share/dotnet";
  };

  home.packages = with pkgs; [
    # Editors & IDEs
    vscode
    neovim

    # AI Assistants
    github-copilot-cli
    claude-code
    opencode
    gemini-cli

    # Databases & Tools
    dbeaver-bin
    insomnia
    redisinsight

    # Build Tools & Language Servers
    tree-sitter
    gcc
    gnumake

    # Programming Languages
    nodejs_24
    python3
    go
    go-tools
    rustc
    cargo
    lua
    jdk
    dotnetCombined

    # Kubernetes & Container Tools
    kubectl
    helm
    minikube
    k9s
    lazydocker
    docker-buildx
    docker-compose

    # AWS Tools
    awscli2
    aws-vault

    # Infrastructure & IaC
    terraform
    terraform-ls
    tflint
    tfsec

    # Git & Version Control
    gh
    git-lfs
    lazygit

    # Nix Tools
    nixpkgs-fmt
    statix
    deadnix
    devenv
    cachix

    # Web & Browser Testing
    cypress
    google-chrome
    chromium
    microsoft-edge
    brave

    # Utilities
    imagemagick
    zellij
  ];
}
