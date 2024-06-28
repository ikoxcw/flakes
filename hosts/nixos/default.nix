{ config, daeuniverse, lib, pkgs, inputs, user, ... }:
{

  imports = [
    ./hardware-configuration.nix
    # ../../module/default.nix
  ];

  networking.hostName = "nixos";

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # sops = {
  #  secrets.sshkey = {
  #    mode = "0600";
  #    owner = "${user}";
  #    path = "/home/" + "${user}" + "/.ssh/openwrt";
  #  };
  #  secrets.rclone = {
  #    mode = "0600";
  #  owner = "${user}";
  #   path = "/home/" + "${user}" + "/.config/rclone/rclone.conf";
  #  };
  #};

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
