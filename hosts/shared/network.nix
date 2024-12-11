{ pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];
    firewall.allowedTCPPorts = [ 25565 ];
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
