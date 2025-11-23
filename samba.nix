{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    samba = {
      package = pkgs.samba4Full;
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        music = {
          path = "/home/user/music";
          writable = "true";
          comment = "Hello World!";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
      };
    };
    avahi = {
      publish.enable = true;
      publish.userServices = true;
      enable = true;
      openFirewall = true;
    };
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [445 139 5030];
  networking.firewall.allowedUDPPorts = [137 138 5030];
  networking.firewall.allowPing = true;
}
