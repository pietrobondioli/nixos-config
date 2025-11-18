{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode
    neovim
    jetbrains.rider
    jetbrains.idea-ultimate
    insomnia
    dbeaver-bin
    tree-sitter
    github-copilot-cli
    claude-code
    lazydocker
    lazygit
    kubectl
    helm
    minikube
    k9s
    nodejs_24
    go
    go-tools
    rustc
    cargo
    zellij
    dotnet-sdk_8
    dotnet-aspnetcore_8
    jdk
    python3
    lua
    gcc
    gnumake
    awscli2
    aws-vault
    gh
    terraform
    terraform-ls
    tflint
    tfsec

    # Nix formatting and linting tools
    nixpkgs-fmt
    statix
    deadnix
  ];
}
