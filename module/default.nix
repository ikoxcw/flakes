{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./core.nix
    ./daed/default.nix
    ./desktop.nix
    ./disk/default.nix
    ./fonts.nix
    ./impermanence.nix
    ./nix.nix
    ./steam.nix
    ./lanzaboote.nix
    # ./xray/nginx.nix
    # ./systemdboot.nix
    # ./virtualisation/default.nix
  ];
}
