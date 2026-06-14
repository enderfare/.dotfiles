{
  description = "My system configuration";

  inputs = {
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
  };

  outputs =
    { self, nixpkgs, nixpkgs-stable, ... }@inputs:

    let
      system = "x86_64-linux";
    in
    {
      overlays.default = final: prev: {
        chronicler = final.callPackage ./nixos/pkgs/chronicler.nix { };
        blueyeti-linux = final.callPackage ./nixos/pkgs/blueyeti-linux.nix { };
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };

          inherit inputs system;
        };

        modules = [
          ({ ... }: {
            nixpkgs.overlays = [ self.overlays.default ];
          })

          inputs.minegrub-world-sel-theme.nixosModules.default
          ./nixos/configuration.nix
        ];
      };
    };
}
