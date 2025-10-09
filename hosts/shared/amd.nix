{ pkgs, ... }:
{
  hardware.graphics = {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
    extraPackages32 = with pkgs; [
    ];
  };

  environment.variables.AMD_VULKAN_ICD = "RADV";
  boot.initrd.kernelModules = [ "amdgpu" ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
}
