{control, lib, ...}: {
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

    nicotine = {
      enable = true;
      socket = true;
      configuration = {
        TZ="Europe/Paris";
        DARKMODE="True";
        UMASK="002";
      };
      paths = {
        directories = {
          "shared" = "/home/user/music";
        };
        downloads = "/home/user/music/downloads";
      };
    };

    metadata-remote = {
      enable = true;
      paths = {
        directories = {
          "music/music" = "/home/user/music/music";
          "music/downloads" = "/home/user/music/downloads";
        };
      };
    };

    picard = {
      enable = true;
      paths = {
        directories = {
          "storage" = "/home/user/music";
        };
      };
    };

    filestash = {
      enable = true;
      paths = {
        directories = {
          "/mnt/music" = "/home/user/music";
        };
      };
    };

    jellyfin = {
      enable = true;
      paths.media = { movies = "/hdd1/media/movies"; };
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
    ./secrets/control.nix
  ];
}
