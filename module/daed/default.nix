{ config, pkgs, inputs, ... }:
{
  imports = [
    ./xray.nix
  ];
  environment.systemPackages = with inputs.daeuniverse.packages.x86_64-linux; [
    dae
    daed
  ];
  services.daed = {
    enable = true;
    listen = "0.0.0.0:25567";
    openFirewall = {
      enable = true;
      port = 12345;
    };
  };
}
