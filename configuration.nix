{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #./samba.nix
    #./slskd.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  users.users.user = {
    isNormalUser = true;
    home = "/home/user";
    description = "Main user, name is arbitrary";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    # openssh.authorizedKeys.keys = [ "" ];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.openssh = {
    enable = true;
    ports = [5432];
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["user"];
      MaxAuthTries = 100;
    };
  };

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

  #virtualisation.oci-containers.containers."navidrome" = {
  #  autoStart = true;
  #  image = "deluan/navidrome:latest";
  #user: 1000:1000 # should be owner of volumes
  #  ports = ["4533:4533"];
  #  environment = {
  # Optional: put your config options customization here. Examples:
  #    ND_SCANSCHEDULE = "1h";
  #    ND_LOGLEVEL = "info";
  #    ND_SESSIONTIMEOUT = "24h";
  #    ND_BASEURL = "";
  #  };
  #  volumes = [
  #    "/home/user/music/navidrome-data:/data"
  #    "/home/user/music/music:/music"
  #  ];
  #};

  environment.variables = {
    TERM = "xterm-256color";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
