{
  pkgs,
  inputs,
  username,
  hostname,
  self,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit
        inputs
        username
        hostname
        self
        ;
    };
    users.jazz = {
      imports = [ (import ./../../home/jazz.nix) ];
      home.username = "jazz";
      home.homeDirectory = "/home/jazz";
      home.stateVersion = "23.11";
      programs.home-manager.enable = true;
    };
    users.${username} = {
      imports = [ (import ./../../home) ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "23.11";
      programs.home-manager.enable = true;
    };
  };
  users = {
    groups = {
      steam.name = "steam";
    };
    users = {
      ${username} = {
        isNormalUser = true;
        description = "${username}";
        homeMode = "755";
        extraGroups = [
          "networkmanager"
          "steam"
          "wheel"
          "adbusers"
          "corectrl"
          "audio"
        ];
        shell = pkgs.zsh;
      };
      jazz = {
        isNormalUser = true;
        description = "jazz";
        extraGroups = [
          "networkmanager"
          "wheel"
          "steam"
          "adbusers"
          "corectrl"
          "audio"
        ];
        shell = pkgs.zsh;
      };
    };
  };
  nix.settings.allowed-users = [
    "${username}"
    "jazz"
  ];
}
