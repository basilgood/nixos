{ config, pkgs, ... }:
{
  networking.networkmanager = { dns = "dnsmasq"; };
}
