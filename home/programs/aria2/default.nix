{ config, user, pkgs, ... }:
{
  programs.aria2 = {
    enable = true;
  };
  systemd.user.services = {
    aria2 = {
      Unit = {
        Description = "aria2 deamon";
        After = "default.target";
        Requires = "default.target";
        PartOf = "default.target";
      };
      Install.WantedBy = [ "default.target" ];
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.aria2}/bin/aria2c --conf-path /home/${user}/.config/aria2c/aria2.conf";
      };
    };
  };
  # home.file = {
  #   ".aria2/".source = ./aria2;
  # };
  imports = [
    ./aria2.nix
  ];
}
