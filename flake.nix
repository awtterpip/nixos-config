{
  description = "otterpip's nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    username = "piper";
  in {
    nixosConfigurations = {
      amethyst = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit self inputs username;};
        modules = [
          (import ./hosts/amethyst)
          (import ./hosts/shared/bootloader.nix)
          (import ./hosts/shared/envision.nix)
          (import ./hosts/shared/hardware.nix)
          (import ./hosts/shared/network.nix)
          (import ./hosts/shared/pipewire.nix)
          (import ./hosts/shared/programs.nix)
          (import ./hosts/shared/security.nix)
          (import ./hosts/shared/services.nix)
          (import ./hosts/shared/steam.nix)
          (import ./hosts/shared/system.nix)
          (import ./hosts/shared/user.nix)
          (import ./hosts/shared/wayland.nix)
        ];
      };
    };
  };
}
