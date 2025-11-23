{ control, ...} :
{
  control = {
    defaultPath = "/home/user";
    navidrome.enable = true;
    jellyfin = {
      enable = true;
      paths.media = { media = "/home/user/media"; };
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
