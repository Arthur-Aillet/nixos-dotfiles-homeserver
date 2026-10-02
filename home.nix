{
  config,
  lib,
  pkgs,
  ...
}: {
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    zsh
    git
    tree
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake /home/user/nixos-dotfiles-homeserver";
      format = "alejandra . &>/dev/null || ( alejandra . ; echo 'formatting failed!' && exit 1)";
      progress = "watch -n 2 tree";
    };

    history.size = 10000;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Arthur-Aillet";
      user.email = "arthur.aillet@epitech.eu";
      init.defaultBranch = "main";
    };
  };
}
