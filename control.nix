{
  control,
  lib,
  ...
}: {
  control = {
    defaultPath = "/home/user";
    navidrome = {
      enable = true;
      subdomain = "music";
      paths.music = {
        "/" = "/home/user/hddA/music";
      };
      paths.data = "/home/user/music/navidrome-data";
      lanOnly = false;
      forceLan = false;
    };

    hdd-spindown.enable = false;

    openspeedtest = {
      enable = true;
      subdomain = "speed";
    };

    # psitransfer = {
    #   subdomain = "transfer";
    #   enable = true;
    # };

    nicotine = {
      enable = true;
      socket = true;
      configuration = {
        TZ = "Europe/Paris";
        DARKMODE = "True";
        UMASK = "002";
      };
      paths = {
        directories = {
          "shared" = "/home/user/hddA/music";
        };
        downloads = "/home/user/hddA/downloads";
      };
      basicAuth = {hopeflea = "password";};
    };

    # metadata-remote = {
    #   enable = true;
    #   paths = {
    #     directories = {
    #       "music/music" = "/home/user/music/music";
    #       "music/downloads" = "/home/user/music/downloads";
    #     };
    #   };
    # };

    picard = {
      enable = false;
      subdomain = "picard";
      basicAuth = {hopeflea = "password";};
      paths = {
        directories = {
          "storage" = "/home/user/hddA/music";
        };
      };
    };

    filestash = {
      enable = true;
      subdomain = "filestash";
      lanOnly = false;
      forceLan = false;
      paths = {
        directories = {
          "/mnt/import" = "/home/user/hddA/import";
        };
      };
    };

    # jellyfin = {
    #   enable = true;
    #   paths.media = { movies = "/hdd1/media/movies"; };
    #   subdomain = "movie";
    # };

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

  # imports = [
  #   ./secrets/lastfm.nix
  #   ./secrets/control.nix
  # ];
}
