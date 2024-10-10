{ pkgs, config, user, inputs, ... }:
{
  programs = {
    dconf.enable = true;
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = [ pkgs.gnome-session ];
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-anthy
      fcitx5-table-extra
      fcitx5-rime
    ] ++ (with pkgs.ikoxcw; [
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
    ]);
  };

  environment = {
    systemPackages = with pkgs; [
      libnotify
      wl-clipboard
      wlr-randr
      xorg.xeyes
      nemo
      wev
      wf-recorder
      pulsemixer
      sshpass
      imagemagick
      grim
      slurp
      linux-wifi-hotspot
      scrcpy
      cattpuccin-frappe-gtk
      qbittorrent-enhanced
    ] ++ [
      inputs.tlock.packages.${system}.default
    ];
    variables.NIXOS_OZONE_WL = "1";
  };

  services.xserver = {
    # xkb.options = "caps:escape";
    # enable = true; #plasma5 config
    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;
  };
  services.sunshine = {
    enable = false;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
  console.useXkbConfig = true;

  programs = {
    light.enable = true;
  };
  services = {
    dbus.packages = [ pkgs.gcr ];
    # getty.autologinUser = "${user}";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  systemd.services."getty@tty1" = {
    overrideStrategy = "asDropin";
    serviceConfig.ExecStart = [ "" "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} --autologin ${user} --noclear --keep-baud %I 115200,38400,9600 $TERM" ];
  };

  programs.adb.enable = true;
  users.users.${user}.extraGroups = [ "adbuser" "bluetooth" ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
