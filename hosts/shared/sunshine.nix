{pkgs, ...}: {
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };
  environment.systemPackages = with pkgs; [
    sunshine
    moonlight-qt
  ];
}
