{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./samba.nix
    ./control.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/disk/by-id/ata-M4-CT064M4SSD2_0000000012390917D3F1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  age.secrets.auth_key = {
    file = ./secrets/auth_key.age;
  };

  system.activationScripts."zz-user-authorizedKeys".text = ''
    mkdir -p "/etc/ssh/authorized_keys.d";
    cp "${config.age.secrets.auth_key.path}" "/etc/ssh/authorized_keys.d/user";
    chmod +r "/etc/ssh/authorized_keys.d/user"
  '';

  users.users.user = {
    isNormalUser = true;
    home = "/home/user";
    description = "Main user, name is arbitrary";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "music"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    git-crypt
    btop
    ffmpeg
    scdl
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.openssh = {
    enable = true;
    ports = [5454];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["user"];
      MaxAuthTries = 10;
    };
  };

  services.fail2ban.enable = true;

  programs.nix-ld.enable = true;
  programs.zsh.enable = true;

  fileSystems."/home/user/music" = {
    device = "/dev/shared/volume";
    fsType = "ext4";
    options = [
      # If you don't have this options attribute, it'll default to "defaults"
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };

  environment.variables = {
    TERM = "xterm-256color";
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
