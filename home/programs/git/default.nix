{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      # package = pkgs.emptyDirectory;
      userName = "ikoxcw";
      userEmail = "78737594+ikoxcw@users.noreply.github.com";
      signing = {
        key = "15B10D98FD00B119";
        signByDefault = true;
      };
      extraConfig = {
        url = {
          "ssh://git@github.com/ikoxcw" = {
            insteadOf = "https://github.com/ikoxcw";
          };
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
