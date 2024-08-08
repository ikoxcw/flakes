{ pkgs, ... }:
# let
#   keyjump = {
#     yazi = {
#       url = "https://raw.githubusercontent.com/DreamMaoMao/keyjump.yazi/main/init.lua";
#       sha256 = "sha256-GVY1nfiCwVFWUp+glxzLuECkzSfNjlueUjA/zD72zmA=";
#     };
#   };
#   keyjumpyazi = keyjump.yazi;
#   keyjump-yazi = pkgs.fetchurl {
#     inherit (keyjumpyazi) url sha256;
#   };
# in
{
  programs.yazi = {
    enable = true;
    # package = yazi.packages.${pkgs.system}.default;
  };

  home.file = {
    ".config/yazi/yazi.toml".source = ./yazi.toml;
    ".config/yazi/keymap.toml".source = ./keymap.toml;
    ".config/yazi/theme.toml".source = ./theme.toml;
    ".config/yazi/init.lua".source = ./init.lua;
    # ".config/yazi/plugins/keyjump.yazi/init.lua".source = "${keyjump-yazi}";
  };

}
