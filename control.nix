{control, ...}: {
  control = {
    defaultPath = "/home/user";
    navidrome = {
      enable = true;
      configuration = {
        ND_LOGLEVEL = "info";
      };
      subdomain = "music";
      paths.music = {
        "/" = "/home/user/music/music";
      };
      paths.data = "/home/user/music/navidrome-data";
      forceLan = true;
    };

    hdd-spindown.enable = true;

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
}
