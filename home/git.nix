{
  pkgs,
  username,
  ...
}: {
  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile /home/${username}/.ssh/id_ed25519.pub}";

  programs.git = {
    enable = true;

    userName = "awtterpip";
    userEmail = "awtterpip@gmail.com";

    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  home.packages = [pkgs.gh pkgs.git-lfs];
}
