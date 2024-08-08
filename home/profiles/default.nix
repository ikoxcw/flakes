{ inputs, config, lib, pkgs, user, ... }:
{
  flake =
    let
      inherit (inputs.home-manager.lib) homeManagerConfiguration;
      user = "kotori";
    in
    {
      homeConfigurations."${user}@nixos" = homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          inputs.hyprland.homeManagerModules.default
          inputs.nur.hmModules.nur
        ];
      };
    };

}
