{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with inputs.daeuniverse.packages.x86_64-linux; [
    dae
    daed
  ];
  services.daed = {
    enable = true;
    listen = "0.0.0.0:2023";
    openFirewall = {
      enable = true;
      port = 12345;
    };
  };
}
