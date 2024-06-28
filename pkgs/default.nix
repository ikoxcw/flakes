{ config, pkgs, ... }:

{

  environment.systemPackages =
    let
      catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors/default.nix { };
      catppuccin-frappe-gtk = pkgs.callPackage ./catppuccin-frappe-gtk/default.nix { };
      ldmtool = pkgs.callPackage ./ldmtool/default.nix { };
    in
    [
      catppuccin-cursors
      catppuccin-frappe-gtk
      ldmtool
    ];
}
