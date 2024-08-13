{
  pkgs,
  inputs,
  username,
  self,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs username self;};
    users.${username} = {
      imports = [(import ./../../home)];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "23.11";
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = ["networkmanager" "wheel" "adbusers" "corectrl" "audio"];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = ["${username}"];
}
