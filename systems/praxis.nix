{ config, pkgs, lib, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";
  };

  imports = [
    ./hardware/praxis.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  boot.initrd.luks.devices."luks-8fc7f13b-5114-4641-809e-127012324396".device = "/dev/disk/by-uuid/8fc7f13b-5114-4641-809e-127012324396";
  services.resolved.enable = true;
  networking.hostName = "praxis";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [
    "*tailscale*"
    "*udev*"
  ];
  networking.networkmanager.connectionConfig."connection.mdns" = 2;
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
    };
  };
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
#   services.xserver.displayManager.sddm.enable = true;
#   services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
        defaultSession = "none+i3";
        lightdm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        #i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };
  programs.dconf.enable = true;

  fonts = {
    fontDir.enable = true;

    packages = [
      pkgs.fira-code
      pkgs.jetbrains-mono
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.naturalScrolling = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "jasonprado";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    eternal-terminal
    glances
    gnumake
    killall
    vim
    i3
    wget
    mosh
    pulseaudio
    python311
    qpaeq
    tailscale
    turbovnc
    udiskie
    xorg.xev
    gnome.gnome-keyring
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  services.tailscale.enable = true;
  networking.firewall.allowedUDPPorts = [
    60001
    60002
    config.services.tailscale.port
  ];
  networking.firewall.allowedTCPPorts = [
    config.services.eternal-terminal.port
    32500  # plexamp
    61208  # glances
  ];

  services.eternal-terminal = {
    enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  services.udisks2.enable = true;

  virtualisation.docker.enable = true;

  location = {
    provider = "manual";
    latitude = 37.767908525563215;
    longitude = -122.41896818465868;
  };

  services.redshift = {
    enable = true;
    brightness = {
      day = "1";
      night = "1";
    };
    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  systemd.services.glances = {
    enable = true;
    description = "Run glances webserver";
    unitConfig = {
      Type = "simple";
    };
    serviceConfig = {
      ExecStart = "${pkgs.glances}/bin/glances -w";
    };
    after = ["network.target"];
    wantedBy = [ "multi-user.target" ];
  };

  services.xserver.displayManager.sessionCommands = ''
    eval $(gnome-keyring-daemon --daemonize)
    export SSH_AUTH_SOCK
  '';

  environment.etc.
  "wireplumber/main.lua.d/98-alsa-dontsleep.lua".text = ''
    alsa_monitor.rules = {
      {
        matches = {{{ "node.name", "matches", "alsa_output.*" }}};
        apply_properties = {
          ["session.suspend-timeout-seconds"] = 0;
        },
      },
    }
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
