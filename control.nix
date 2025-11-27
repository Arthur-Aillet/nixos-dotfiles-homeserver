{control, ...}: {
  control = {
    defaultPath = "/home/user";
    navidrome = {
      enable = true;
      subdomain = "music";
      paths.music = {
        "/" = "/home/user/music/music";
      };
      paths.data = "/home/user/music/navidrome-data";
      forceLan = true;
    };

    hdd-spindown.enable = true;

    openspeedtest = {
      enable = true;
      subdomain = "speed";
    };

    psitransfer = {
      subdomain = "transfer";
      enable = true;
    };

    # system.activationScripts."psi-transfer-password" = ''
    #   secret=$(cat "${config.age.secrets.psi_transfer.path}")
    #   configFile=/run/dex/config.yaml
    #   ${pkgs.gnused}/bin/sed -i "s#@TEMPORARY-PSI-TRANSFER-PASSWORD@#$secret#" "$configFile"
    # '';

    jellyfin = {
      enable = true;
      paths.media = {movies = "/hdd1/media/movies";};
      subdomain = "movie";
    };

    routing = {
      enable = true;
      domain = "hopeflea.net";
      letsencrypt = {
        enable = true;
        email = "ailletarthur70@gmail.com";
      };
      checkClientCertificate = true;
    };
  };
  imports = [
    ./secrets/lastfm.nix
  ];
}
