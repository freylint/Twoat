{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    trait = import ./os/lib/traitlib.nix { inherit self home-manager; };
  in {
    nixosConfigurations = {
      gdw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          {
            networking.hostName = "gdw";
            time.timeZone = "America/New_York";
            system.stateVersion = "23.11";
          }
          ./os/machine/gdw.nix
          ./os/machine/bootable.nix
          ./os/machine/networked.nix
          ./os/machine/amdgpu.nix
          ./os/users/gen.nix
          ./os/env/base.nix
          ./os/env/sound.nix
          ./os/env/suid.nix
          ./os/env/gui.nix
          ./os/env/games.nix
          ./os/apps/office.nix

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.gen = { config, pkgs, ... }: {
                imports = [ 
                  ./apps/git.nix
                  ./apps/tweaks.nix
                  ./apps/vscode.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}