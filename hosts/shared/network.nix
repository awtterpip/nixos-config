{ pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];
    firewall.allowedTCPPorts = [
      25565
      9757
      27036
      27037
    ];
    firewall.allowedUDPPorts = [
      10401
      27031
      27036
      10400
      5353
      9757
    ];
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
