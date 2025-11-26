{control, ...}: {
  control = {
    defaultPath = "/home/user";
    navidrome = {
      enable = true;
      configuration = {
        ND_LASTFM_APIKEY = "d5955661481253861b2d1f6e2cf282f4";
        ND_LASTFM_SECRET = "8bb5e92034c3b05dd5ed04bac138f6c6";
      };
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
      forceLan = true;
    };

    psitransfer = {
      subdomain = "transfer";
      enable = true;
    };

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
}
