{ config, daeuniverse, lib, pkgs, inputs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
    gamescopeSession.env = {
      GTK_IM_MODULE = "xim";
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    package = pkgs.steam.override {
      extraPkgs = pkgs: [
        pkgs.noto-fonts
        pkgs.noto-fonts-cjk
        pkgs.noto-fonts-emoji
        pkgs.twemoji-color-font
        (pkgs.nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" "Iosevka" "IosevkaTerm" "NerdFontsSymbolsOnly" "DaddyTimeMono" ]; }) #fonts name can get in ``https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerdfonts/shas.nix`
      ];
      extraEnv = {
        GTK_IM_MODULE = "xim";
      };
    };
  };
  environment.systemPackages = [
    pkgs.protontricks
  ];
}
