{ config, lib, pkgs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    zsh
    git
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake /home/user/.dotfiles";
    };

    history.size = 10000;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  programs.git = {
    enable = true;
    userName="Arthur-Aillet";
    userEmail="arthur.aillet@epitech.eu";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
