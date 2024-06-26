# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # fileSystems."/" =
  #   { device = "/dev/disk/by-uuid/086177d7-35ef-493a-b7e5-6d295c0a3181";
  #     fsType = "btrfs";
  #     options = [ "subvol=root" "compress=zstd" ];
  #   };
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=25%" "mode=755" ];
  };

  # fileSystems."/home" =
  #   { device = "/dev/disk/by-uuid/086177d7-35ef-493a-b7e5-6d295c0a3181";
  #     fsType = "btrfs";
  #     options = [ "subvol=home" "compress=zstd" ];
  #   };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/086177d7-35ef-493a-b7e5-6d295c0a3181";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FBCD-E8F5";
    fsType = "vfat";
  };


  fileSystems."/home/kotori/win/c" = {
    device = "/dev/disk/by-uuid/96D84B0CD84AE9D7";
    fsType = "ntfs";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
