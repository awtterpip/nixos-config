{...}: {
  programs.zsh.enable = true;
  programs.gnupg.agent.enable = true;
  programs.ssh.startAgent = true;
  programs.adb.enable = true;
  programs.droidcam.enable = true;
}
