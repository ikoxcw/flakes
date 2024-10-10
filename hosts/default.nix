{ inputs, user, sharedModules, homeImports, wslModules, ... }:
{
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      nixos = nixosSystem {
        specialArgs = { inherit user; };
        modules = [
          ./nixos
          ../module/lanzaboote.nix
          # ../module/systemdboot.nix
          ../module/impermanence.nix
          ../module/desktop.nix
          ../module/fonts.nix
          ../module/virtualisation
          ../module/steam.nix
          ../module/disk/default.nix
          # ../module/nginx/nginx.nix


          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user}.imports = homeImports."${user}@nixos";
              extraSpecialArgs = { inherit inputs user; };
            };
          }
        ] ++ sharedModules;
      };

      minimal = nixosSystem {
        specialArgs = { inherit user; };
        modules =
          [
            ./minimal
            ../modules/impermanence.nix
            ../modules/systemdboot.nix
          ] ++ sharedModules;
      };

      cutw = nixosSystem {
        specialArgs = { inherit user; };
        modules =
          [
            ./cutw
            {
              home-manager = {
                extraSpecialArgs = { inherit user; };
                users.${user}.imports = homeImports."${user}@cutw";
              };
            }
          ] ++ wslModules;
      };
    };
}
