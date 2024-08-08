{ inputs, config, lib, pkgs, ... }:
{
  flake.nixosConfigurations =
    let
      user = "kotori";
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      nixos = nixosSystem {
        specialArgs = { inherit user inputs; };
        modules = [
          ./nixos
          ../module/default.nix
          ../pkgs
          ../overlays/yazi.nix
          inputs.daeuniverse.nixosModules.dae
          inputs.daeuniverse.nixosModules.daed
          inputs.impermanence.nixosModules.impermanence
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.sops-nix.nixosModules.sops
          inputs.disko.nixosModules.disko
          inputs.nur.nixosModules.nur
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ../home/default.nix;
            home-manager.extraSpecialArgs = { inherit inputs user; };
          }

          ({
            nixpkgs.overlays = [
              (final: prev: {
                ikoxcw = inputs.ikoxcw.packages."${prev.system}";
              })
            ];
          })
        ];
      };
    };
}
