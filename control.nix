{control, ...}: {
  control = {
    defaultPath = "/home/user";
    navidrome = {
      enable = true;
      subdomain = "music";
    };

    jellyfin = {
      enable = true;
      paths.media = {media = "/home/user/media";};
      subdomain = "movie";
    };

    routing = {
      enable = true;
      domain = "hopeflea.net";
      letsencrypt = {
        enable = true;
        email = "ailletarthur70@gmail.com";
      };
    };
  };
}
