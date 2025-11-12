{ lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Pietro Bondioli";
        email = "email@pietrobondioli.com.br";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBkYROpWTR4k2G7mzsT9I3SFhlL9A3wRPKHepcHmpIU";
        enableSigning = true;
      };
      url."git@github.com:".insteadOf = "https://github.com/";
      gpg.format = "ssh";
      gpg.ssh.program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      push.autoSetupRemote = true;
      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
      apply.whitespace = "fix";
      grep.lineNumber = true;
      branch.sort = "-committerdate";
      color.ui = true;
      rebase.autoStash = true;
      gist.private = "yes";
      log.decorate = "short";
      fetch = { prune = true; output = "compact"; };
      help.autocorrect = "prompt";
      merge = { log = true; conflictstyle = "diff3"; };
    };
  };
}