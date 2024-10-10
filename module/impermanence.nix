{ user, config, ... }:
{
  environment = {
    persistence."/nix/persist" = {
      directories = [
        "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
        "/etc/NetworkManager/system-connections"
        "/var/log"
        "/var/lib"
        "/etc/secureboot"
        "/etc/daed"
      ];
      files = [
        # "/etc/machine-id"
        "/etc/create_ap.conf"
      ];
      users.${user} = {
        directories = [
          # "Blog"
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".cache"
          # "Codelearning"
          ".npm-global"
          ".config"
          ".thunderbird"
          "flakes"
          "Kvm"
          # "Projects"
          "rclone"
          "restic"
          # "win"
          ".aria2"
          ".cabal"
          ".cargo"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          ".local"
          ".mozilla"
          ".emacs.d"
          ".steam"
        ];
        files = [
          ".npmrc"
        ];
      };
    };
  };
}
