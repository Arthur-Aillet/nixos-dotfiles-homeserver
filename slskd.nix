{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.services.slskd.serviceConfig = {
    User = lib.mkForce "user";
    Group = lib.mkForce "users";
  };

  fileSystems."/var/lib/slskd/music" = {
    device = "/home/user/music/music";
    options = ["bind"];
  };

  fileSystems."/var/lib/slskd/downloads" = {
    device = "/home/user/music/downloads";
    options = ["bind"];
  };

  fileSystems."/var/lib/slskd/incomplete" = {
    device = "/home/user/music/incomplete";
    options = ["bind"];
  };

  services.slskd = {
    enable = true;
    domain = "";
    environmentFile = "/home/user/.dotfiles/slskd/slskdenv";
    settings = {
      shares.directories = ["/var/lib/slskd/music"];
    };
  };
}
