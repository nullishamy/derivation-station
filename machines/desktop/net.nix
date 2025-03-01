{config, ...}: {
  networking = {
    useDHCP = true;
    useNetworkd = true;
    hostName = "nixon";
    firewall.enable = false;
  };

  # systemd.network.networks = let
  #   networkConfig = {
  #     DHCP = "yes";
  #   };
  # in {
  #   # Config for all useful interfaces
  #   "40-wired" = {
  #     enable = true;
  #     name = "en*";
  #     inherit networkConfig;
  #     dhcpV4Config.RouteMetric = 1024; # Better be explicit
  #   };
  #   "40-wireless" = {
  #     enable = true;
  #     name = "wl*";
  #     inherit networkConfig;
  #     dhcpV4Config.RouteMetric = 2048; # Prefer wired
  #   };
  # };

  # Wait for any interface to become available, not for all
  # This avoids a hang where wifi isnt available
  systemd.services."systemd-networkd-wait-online".serviceConfig.ExecStart = [
    ""
    "${config.systemd.package}/lib/systemd/systemd-networkd-wait-online --any"
  ];
}
