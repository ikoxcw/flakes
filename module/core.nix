{ pkgs, user, config, inputs, ... }:
{
  # NOTE: https://github.com/Mic92/sops-nix#initrd-secrets
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.sshKeyPaths = [ ];
  sops.gnupg.sshKeyPaths = [ ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt"; # You must back up this keyFile yourself
  sops.age.generateKey = true;
  # issue: https://github.com/Mic92/sops-nix/issues/149
  # workaround:
  systemd.services.decrypt-sops = {
    description = "Decrypt sops secrets";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = "2s";
    };
    script = config.system.activationScripts.setupSecrets.text;
  };

  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
      LANGUAGE = "en_US.UTF-8";
    };
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "C.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "zh_TW.UTF-8/UTF-8"
    ];
  };

  networking = {
    networkmanager.enable = true;
    hosts = {
      "185.199.109.133" = [ "raw.githubusercontent.com" ];
      "185.199.111.133" = [ "raw.githubusercontent.com" ];
      "185.199.110.133" = [ "raw.githubusercontent.com" ];
      "185.199.108.133" = [ "raw.githubusercontent.com" ];
      "192.168.1.198" = [
        "firefox.com.cn"
        "download-ssl.firefox.com.cn"
        "firefoxchina.cn"
        "home.firefoxchina.cn"
        "start.firefoxchina.cn"
        "flash.cn"
        "directads.mcafee.com"
        "ads.mcafee.com"
      ];
    };
  };

  security.rtkit.enable = true;
  services.openssh = {
    ports = [ 25566 ];
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  users.mutableUsers = false;
  users.users.root = {
    initialHashedPassword = "$y$j9T$KMe2e/BhNUJ/VnIZOMmhB/$.k0Js7115Jk8iZAGyNU2rK/AG16.56v7gk8bwrUp4i0";
  };
  programs.fish.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$owwwWsfU9sj/Qa3D3VvXK0$paUL1d.oyIC5nejR0GMG/TMBsY0X5FHh5TrhprMzTd2";
    description = "${user}";
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5gMaeV2ehMMUMd7jbIHT4PXCSGkYv7A0WiseMymMoP yuki"
    ];
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    extraConfig = ''
      ${user} ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      gcc
      clang
      git
      gdb
      neovim
      wget
      neofetch
      eza
      p7zip
      atool
      unzip
      zip
      rar
      ffmpeg
      xdg-utils
      pciutils
      killall
      socat
      sops
      lsof
      # config.nur.repos.xddxdd.qbittorrent-enhanced-edition
    ];
  };

  services.dbus.enable = true;

  system.stateVersion = "23.11";

}
