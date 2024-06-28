{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        Hostname ssh.github.com
        Port 443
        User git
      Host nixos.lan
        Hostname 192.168.168.1
        Port 22
        User root
        IdentityFile ~/.ssh/openwrt
    '';
  };
}
