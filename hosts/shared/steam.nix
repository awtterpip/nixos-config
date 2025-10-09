{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    protontricks.enable = true;
    extraPackages = with pkgs; [
      libnss_nis
      nss
      (python3.withPackages (python-pkgs: [
        python-pkgs.pillow
      ]))
    ];
  };
  programs.gamemode.enable = true;
}
