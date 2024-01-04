{ config, pkgs, ... }:
{
  # remove the annoying experimental warnings
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  networking = {
    useNetworkd = true;
    useDHCP = false;
    firewall.enable = true;
  };

  # https://nixos.wiki/wiki/Systemd-networkd#Bonding
  systemd.network = {
    enable = true;
    networks = {
      "10-lan" = {
        name = "enp0*";
        enable = true;
        networkConfig.DHCP = "yes";
        # this port is not always connected and not required to be online
        linkConfig.RequiredForOnline = "no";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    vim
    efibootmgr
  ];

  services.openssh = {
    enable = true;
    openFirewall = true;
  };
}
