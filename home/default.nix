{ config, pkgs, user, inputs, lib, ... }:
{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    language.base = "en_US.UTF-8";
  };
  programs = {
    home-manager.enable = true;
  };
  home.stateVersion = "23.11"; # please read the comment before changing.

  imports =
    [
      ./wm/hyprland
      # ./wm/sway
      ./wall
      ./terminals
      ./editors
      ./shell
    ] ++ (import ./programs);

  wayland.windowManager.hyprland = lib.mkIf config.wayland.windowManager.hyprland.enable { };

  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = [ "qemu:///system" ];
  #     uris = [ "qemu:///system" ];
  #   };
  # };
  # Modules = [
  #   # module_args
  #   inputs.hyprland.homeManagerModules.default
  #   # inputs.nix-index-database.hmModules.nix-index
  #   # inputs.nur.hmModules.nur
  # ];
}
