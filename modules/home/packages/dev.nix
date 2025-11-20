{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Editors & IDEs
    vscode
    neovim

    # AI Assistants
    github-copilot-cli
    claude-code

    # Databases & Tools
    dbeaver-bin
    insomnia

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
    dotnet-sdk_8
    dotnet-aspnetcore_8

    # Kubernetes & Container Tools
    kubectl
    helm
    minikube
    k9s
    lazydocker

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

    # Web & Browser Testing
    cypress
    google-chrome
    microsoft-edge
    brave

    # Utilities
    imagemagick
    zellij
  ];
}
