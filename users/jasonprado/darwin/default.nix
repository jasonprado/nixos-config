{ pkgs, lib, user, writeShellScriptBin, ... }:
let
  my-python-packages = ps: with ps; [
    pandas
    virtualenv
    requests
  ];
in
{
  programs.zsh.enable = true;
  users.users.${user}.home = "/Users/${user}";

  services = {
    lorri.enable = true;
    nix-daemon.enable = true;
  };

  environment = {
    loginShell = "${pkgs.zsh}/bin/zsh -l";
    variables.SHELL = "${pkgs.zsh}/bin/zsh";
    variables.LANG = "en_US.UTF-8";
    systemPackages =
      [
        pkgs.awscli
        pkgs.coreutils
        pkgs.curl
        pkgs.ffmpeg
        pkgs.jq
        pkgs.mosh
        pkgs.ripgrep
        pkgs.shellcheck
        pkgs.python39
        pkgs.glances
        (pkgs.writeShellScriptBin "macos-start-terminals" (lib.readFile ../bin/macos-start-terminals))
      ];
  };

  nix.settings.experimental-features = "nix-command flakes";

  system = {
    stateVersion = 4;
    activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
    defaults = {
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 25;
        KeyRepeat = 6;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        _HIHideMenuBar = false;
      };

      dock = {
        # no-bounce = true;
        mru-spaces = false;
        orientation = "left";
        showhidden = true;
        autohide = true;
        tilesize = 28;
        launchanim = false;
        show-process-indicators = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = false;
        # Breadcrumbss
        ShowPathbar = true;
        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";
        # Default view list 
        FXPreferredViewStyle = "Nlsv";
      };

      trackpad = {
        Clicking = false;
        TrackpadThreeFingerDrag = true;
      };

      CustomUserPreferences = {
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          # Check for software updates daily, not just once per week
          ScheduleFrequency = 1;
          # Download newly available updates in background
          AutomaticDownload = 1;
          # Install System data files & security updates
          CriticalUpdateInstall = 1;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
      };
    };

    keyboard.enableKeyMapping = true;
  };

  security.pam.enableSudoTouchIdAuth = true;

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };
}